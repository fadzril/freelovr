require File.dirname(__FILE__) + '/test_helper'

class SprocketsTest < ActiveSupport::TestCase
  test "source files encryption" do
    source_files = ["application.js", "source.js"]
    assert_equal ERB::Util.h(Base64.encode64(source_files.to_json)).sub(/\n$/, ''), Sprocket.encode(source_files)
  end

  test "source files decryption" do
    source_files = ["application.js", "source.js"]
    assert_equal source_files, Sprocket.decode(Sprocket.encode(source_files))
  end

  test "filtering source files by presence in app/javascripts" do
    source_files = ["application.js", "source.js", "../config/database.yml"]
    sprocket = Sprocket.new( Sprocket.encode(source_files) )
    assert_equal source_files[0..1].map { |f| File.join(Sprocket.scripts_root, f) }, sprocket.source_files
  end
end
