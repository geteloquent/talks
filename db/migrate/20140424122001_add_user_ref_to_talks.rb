class AddUserRefToTalks < ActiveRecord::Migration
  def change
    add_reference :talks, :user, index: true
  end
end
