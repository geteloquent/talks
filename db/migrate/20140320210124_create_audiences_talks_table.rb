class CreateAudiencesTalksTable < ActiveRecord::Migration
  def change
    create_table :audience_talks do |t|
      t.belongs_to :audience
      t.belongs_to :talk
    end
  end
end
