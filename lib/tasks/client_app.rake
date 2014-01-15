namespace :cadinsor do
  namespace :client_app do
    desc "Add a new client app"
    task create: :environment do
      app = Cadinsor::ClientApp.new
      print "Enter the client app name: "
      app.name = STDIN.gets.chomp
      app.generate_secret!
      puts
      print "Enter the app secret(blank: #{app.secret}): "
      secret = STDIN.gets.chomp
      app.secret = secret unless secret == ""
      if app.save
        puts "App saved successfully with id: #{app.id}."
        puts app.inspect
      else
        puts "App could not be created."
        puts app.errors.full_messages
      end
    end

    desc "List all client apps with their secrets"
    task list: :environment do
      Cadinsor::ClientApp.all.each do |app|
        puts "*************"
        puts "App id: " + app.id.to_s
        puts "Name: " + app.name
        puts "App secret: " + app.secret
        puts "*************"
        puts
      end
    end

    desc "Edit App Secret"
    task edit_secret: :list do
      print "Please enter the id of the app you would like to edit: "
      id = STDIN.gets.chomp.to_i
      app = Cadinsor::ClientApp.find_by_id(id)
      if app
        puts
        app.generate_secret!
        print "Enter the new secret (blank: #{app.secret}): "
        secret = STDIN.gets.chomp
        puts
        app.secret = secret unless secret == ""
        if app.save
          puts "App saved successfully with secret: #{app.secret}."
          puts app.inspect
        else
          puts "App could not be saved."
          puts app.errors.full_messages
        end
      else
        puts "Invalid id. Quitting!"
      end
    end

    desc "Delete App"
    task delete: :list do
      print "Please enter the id of the app you would like to delete: "
      id = STDIN.gets.chomp.to_i
      app = Cadinsor::ClientApp.find_by_id(id)
      if app
        puts
        print "This option cannot be undone. Hit Yes if you are sure, anything else to quit. "
        response = STDIN.gets.chomp
        puts
        if response == "Yes"
          if app.destroy
            puts "App deleted successfully."
          else
            puts "App could not be deleted."
            puts app.errors.full_messages
          end
        else
          puts "Quitting without deleting app"
        end
      else
        puts "Invalid id. Quitting!"
      end
    end


  end
end