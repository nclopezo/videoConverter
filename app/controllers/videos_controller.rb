class VideosController < ApplicationController

  before_filter :authenticate_user!

  # GET /videos
  # GET /videos.json
  def index
    @videos = current_user.videos

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @videos }
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = current_user.videos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.json
  def new
    @video = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/1/edit
  def edit
    @video = current_user.videos.find(params[:id])
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(params[:video])

    @video.user_id = current_user.id

    @video.name = @video.avatar.filename.to_s
    @video.url_original = @video.avatar.store_dir.to_s
    @video.status = VIDEOS_STATUSES[:PENDING]

    # ahora lo voy a poner en la cola

    # Create an IronMQ::Client object
    @ironmq = IronMQ::Client.new()

    # Get a queue (if it doesn't exist, it will be created when you first post a message
    @queue = @ironmq.queue("my_queue")

    # Post a message
    @queue.post('CONVERT:'+@video.name + 'USER:'+@video.user.id)

# Get a message
    #ok
    #@video.status= @queue.get()



    #@cloud_file.name = @cloud_file.avatar.filename.to_s

    #@cloud_file.size = @cloud_file.avatar.file.size

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render json: @video, status: :created, location: @video }
      else
        format.html { render action: "new" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end
end
