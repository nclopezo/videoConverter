class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :url_original
      t.string :url_converted
      t.string :status

      t.timestamps
    end
  end
end
