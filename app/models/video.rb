class Video < ActiveRecord::Base

  PRODUCTION_BUCKET  = "videoConvProd/"
  DEVELOPMENT_BUCKET = "videoConvDev/"


  AMAZON_S3_BASE_URL =   "https://s3.amazonaws.com/"


  PRODUCTION_BUCKET_URL =AMAZON_S3_BASE_URL + PRODUCTION_BUCKET
  DEVELOPMENT_BUCKET_URL =AMAZON_S3_BASE_URL + DEVELOPMENT_BUCKET


  attr_accessible :name, :status, :url_converted, :url_original, :user_id, :avatar

  mount_uploader :avatar, AvatarUploader

  belongs_to :user

  def complete_url
    if Rails.env.development?
      return DEVELOPMENT_BUCKET_URL + self.url_original + "/" + self.name
    elsif Rails.env.production?
      return PRODUCTION_BUCKET_URL + self.url_original + "/" + self.name
    end
  end

  def status

    progress =   Zencoder::Job.progress(self.job_id, :api_key => ZENCODER_API_KEY)
    @status =   progress.body["state"]

    if @status <=> "finished"

      puts 'ya acaboooooooo'

      #getJobOutput progress


    else

      puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'


      self.status = @status


    end


    return @status
  end

   def getJobOutput(prog)

       @output_id = progress.body["outputs"][0]["id"]

   end


  def checkJobStatus


    puts 'voy a revisar el estado del job en zencoder'

    progress =   Zencoder::Job.progress(self.job_id, :api_key => ZENCODER_API_KEY)

    puts  progress

    puts progress.body["state"]



    self.save

  end

end
