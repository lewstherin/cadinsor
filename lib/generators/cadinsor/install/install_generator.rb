class Cadinsor::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  desc "RailsAdmin installation generator"
  def install
    puts "Creating an initializer for Cadinsor."
    template "cadinsor_initializer.erb", "config/initializers/cadinsor.rb"
    puts "Installing Migrations..."
    system("rake cadinsor:install:migrations")
    puts "Please run rake db:migrate to complete the setup."
  end
end
