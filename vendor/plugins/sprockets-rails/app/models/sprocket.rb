class Sprocket
  mattr_reader :scripts_root
  @@scripts_root = File.join(Rails.root, "app", "javascripts")
  attr_reader :source_files
  
  class << self
    def encode source_files
      ERB::Util.h(Base64.encode64(source_files.to_json).gsub("\n",''))
    end

    def decode hash
      ActiveSupport::JSON.decode URI.unescape(Base64.decode64(hash))
    end
  end

  def initialize sources_hash
    @sources_hash = sources_hash
    self.source_files = sources_hash
  end

  def source_files= sources_hash
    ext = "js"
    @source_files ||= Sprocket.decode(sources_hash).map do |f|
      source = File.expand_path File.join(Sprocket.scripts_root, f)
      source_ext = File.extname(source)[1..-1]
      if ext && (source_ext.blank? || (ext != source_ext && File.exist?("#{source}.#{ext}")))
        source += ".#{ext}"
      end
      source
    end.select { |f| f.starts_with? Sprocket.scripts_root }
  end

  def source
    concatenation.to_s
  end

  def install_script
    # /public/sprocktes might not exist yet, and sprockets-1.0.2 throws an exception
    FileUtils.mkdir_p(File.dirname(asset_path))
    concatenation.save_to(asset_path)
  end

  def install_assets
    secretary.install_assets
  end

  protected
  def secretary
    @secretary ||= Sprockets::Secretary.new(self.class.configuration.merge(:root => Rails.root, :source_files => source_files))
  end

  def self.configuration
    YAML.load(IO.read(File.join(RAILS_ROOT, "config", "sprockets.yml"))) || {}
  end

  def concatenation
    secretary.reset! unless source_is_unchanged?
    secretary.concatenation
  end

  def source_is_unchanged?
    previous_source_last_modified, @source_last_modified = 
      @source_last_modified, secretary.source_last_modified
      
    previous_source_last_modified == @source_last_modified
  end

  def asset_path
    File.join(Rails.public_path, "sprockets.js")
  end
end
