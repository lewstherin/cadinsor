namespace :cadinsor do
  namespace :api_key do


    desc "Remove all expired keys from the db. Interactive task that requires manual confirmation. Please use clean_background if you want to run this in a non-interactive mode."
    task clean_manual: :environment do
      puts
      print "This option cannot be undone. Are you sure (Yes to continue)? "
      response = STDIN.gets.chomp
      if response == "Yes"
        Cadinsor::ApiKey.all.each do |key|
          key.destroy if key.expired?
        end
      else
        puts "Quitting!"
      end
    end

    desc "Remove all expired keys from the db. There will be no confirmation. Please use this for background tasks like cron jobs only."
    task clean_background: :environment do
      Cadinsor::ApiKey.all.each do |key|
        key.destroy if key.expired?
      end
    end


  end
end