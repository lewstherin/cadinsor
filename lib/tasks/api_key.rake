namespace :cadinsor do
  namespace :api_key do

    desc " Interactive task to remove expired keys from the db, please use clean_background if you want to run this in a non-interactive mode."
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

    desc "Remove all expired keys from the db without any confirmation, for background tasks like cron jobs only."
    task clean_background: :environment do
      Cadinsor::ApiKey.all.each do |key|
        key.destroy if key.expired?
      end
    end


  end
end