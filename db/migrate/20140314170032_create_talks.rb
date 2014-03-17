class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.date :deadline

      t.timestamps
    end

    add_index :talks, :slug, unique: true
  end
end
