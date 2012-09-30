class Video < ActiveRecord::Base
  attr_accessible :name, :status, :url_converted, :url_original, :user_id

  belongs_to :user
end
