class AddDurationToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :duration, :string
  end
end
