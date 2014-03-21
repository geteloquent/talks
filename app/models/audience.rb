class Audience < ActiveRecord::Base
  has_many :audience_talks
  has_many :talks, through: :audience_talks

  validates :name, presence: true
end
