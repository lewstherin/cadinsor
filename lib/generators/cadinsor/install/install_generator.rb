class Cadinsor::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  desc "RailsAdmin installation generator"
  def install
    puts "Creating an initializer for Cadinsor."
    template "cadinsor_initializer.erb", "config/initializers/cadinsor.rb"
    puts "Your initializer has been successfully created."
    puts "Installing Migrations..."
    system("rake cadinsor:install:migrations")
    puts "That is done."
    puts "You now have to perform two steps to install the application: "
    puts "1. Add an entry in routes.rb to mount the cadinsor engine."
    puts 'Ex: To mount it at /cadinsor, your route should read: mount Cadinsor::Engine => "/cadinsor"'
    puts "2. Run rake db:migrate to complete the setup."
    puts "\n"
  end
end
