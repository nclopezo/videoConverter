class Video < ActiveRecord::Base
  attr_accessible :name, :status, :url_converted, :url_original, :user_id, :avatar

  mount_uploader :avatar, AvatarUploader

  belongs_to :user
end
