set :output, "/home/sargantana/apps/sargantanacode/current/log/cron.log"

every 1.day, at: '21pm' do
  rake '-s sitemap:refresh:no_ping'
end
