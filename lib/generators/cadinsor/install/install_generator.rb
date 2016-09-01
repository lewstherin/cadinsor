class Cadinsor::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  def install
    puts "I need rabl to work. Adding rabl to your gem file"
    gsub_file "Gemfile", /gem "rabl.*$/, ""
    append_to_file "Gemfile", "\ngem \"rabl\", \"~> 0.9\""
    Bundler.with_clean_env do
      run "bundle install"
    end
    puts "Creating an initializer for Cadinsor..."
    template "cadinsor_initializer.erb", "config/initializers/cadinsor.rb"
    puts "Your initializer has been successfully created at config/initializers/cadinsor.rb."
    puts "Specify your database type. 1 for SQL(MySQL, PostgreSQL, etc). 2 for NoSQL(MongoDB)."
    db_type = gets.chomp.to_i
    if db_type == 1
      puts "Installing Migrations..."
      system("rake cadinsor:install:migrations")
      puts "That is done."
    end
    puts "Adding route to mount the engine..."
    print "Where would you like the engine to be mounted at (default: /cadinsor)? /"
    namespace = gets.chomp
    namespace = "cadinsor" if namespace.to_s == ""
    gsub_file "config/routes.rb", /mount Cadinsor::Engine(.*)/, ''
    insert_into_file "config/routes.rb", "\tmount Cadinsor::Engine, at: '/#{namespace}'", :after => "Rails.application.routes.draw do\n"
    puts "I have tried to add an entry into routes.rb to mount the engine. Printing contents of config/routes.rb"
    system("cat config/routes.rb | more")
    puts "Please verify that an entry exists. If not, create one like shown below."
    puts 'Ex: To mount it at /cadinsor, your route should read: mount Cadinsor::Engine => "/cadinsor"'
    if db_type == 1
      puts "Once that is done, run rake db:migrate to complete the setup."
    end
    puts "\n"
    puts "Cheers!"
  end
end
