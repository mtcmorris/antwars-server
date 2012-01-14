namespace :games do
  task :run => :environment do
    while true  do


      # round = Time.now.to_s
      if Bot.active.count <= 1
        puts "There needs to be two uploaded bots to fight"
        exit
      end

      bot_1, bot_2 = *Bot.active.all.sample(2)
      match = Match.create(bot_one: bot_1, bot_two: bot_2)

      match.run!

      sleep 20
    end
  end

  # # Create 10 fake users and upload a bot for each one
  # task :dev_data => :environment do
  #   bot_ai = File.open("#{Rails.root}/googleai/bot.zip")
  #   10.times do |i|
  #     user = User.create!({:email => Faker::Internet.email, :bot_name => "bot#{i}",
  #                           :password => "password", :password_confirmation => "password"})
  #     bot = user.bots.create!({:source => bot_ai})
  #   end
  # end
end
