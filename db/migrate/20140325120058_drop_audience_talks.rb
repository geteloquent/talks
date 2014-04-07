class DropAudienceTalks < ActiveRecord::Migration
  def change
    drop_table :audience_talks
  end
end
