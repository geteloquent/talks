class DropAudiencesTalksTable < ActiveRecord::Migration
  def change
    drop_table :audiences_talks
  end
end
