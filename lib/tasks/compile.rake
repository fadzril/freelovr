namespace :compile do
  desc "Compile Sprockets JavaScript file"
  task :sprockets => :environment do
    secretary = Sprockets::Secretary.new(
      :asset_root   => "public",
      :load_path    => ["app/javascripts/", "app/javascripts/vendor"],
      :source_files => ["app/javascripts/*.js"]
    )

    # Generate a Sprockets::Concatenation object from the source files
    concatenation = secretary.concatenation

    # Write the concatenation to disk
    concatenation.save_to("public/javascripts/application.js")

    # Install provided assets into the asset root
    secretary.install_assets
  end
end