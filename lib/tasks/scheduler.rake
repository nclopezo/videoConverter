desc "This task is called by the Heroku scheduler add-on"
#require 'app/config/environment.rb'
require 'delayed_job'
require 'delayed/tasks'



begin

   task :checkJobs => :environment do




    puts 'running job'



    time = Time.new

    puts "Current Time : " + time.inspect
    puts "Reading Queue"

    # Create an IronMQ::Client object
    @ironmq = IronMQ::Client.new()

    # Get a queue (if it doesn't exist, it will be created when you first post a message
    @queue = @ironmq.queue("videosConv")
    # Get a message
    msg = @queue.get()



    if msg.nil?
      puts "No Message"
    else

      puts "Message:"
      puts msg.body

      @messageStr = msg.body.to_s

      @videoID = @messageStr.split(",")[0].split(":")[1]

      puts @videoID

      @userID = @messageStr.split(",")[1].split(":")[1]

      puts @userID

      @user = User.find(@userID)

      @video = Video.find(@videoID)

      @video.status = VIDEOS_STATUSES[:PROCESSING ]

      @video.save

      #msg.delete

      #puts @video.url_original

      puts "done."

    end


   end


end


