class CreateJoinTableAudienceTalk < ActiveRecord::Migration
  def change
    create_join_table :audiences, :talks do |t|
      # t.index [:audience_id, :talk_id]
      # t.index [:talk_id, :audience_id]
    end
  end
end
