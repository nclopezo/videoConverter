desc "This task is called by the Heroku scheduler add-on"

task :checkForVideos => :environment do
  puts "Reading Queue"

  puts "done."
end

