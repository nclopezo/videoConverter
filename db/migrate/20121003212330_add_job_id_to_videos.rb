class AddJobIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :job_id , :integer
  end
end
