class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :url
      t.belongs_to :talk

      t.timestamps
    end
  end
end
