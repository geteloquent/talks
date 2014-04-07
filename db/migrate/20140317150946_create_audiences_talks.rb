class CreateAudiencesTalks < ActiveRecord::Migration
  def change
    create_table :audiences_talks, id: false do |t|
      t.integer :audience_id
      t.integer :talk_id
    end
  end
end
