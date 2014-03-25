class Audience < ActiveRecord::Base
  has_and_belongs_to_many :talks

  validates :name, presence: true
end
