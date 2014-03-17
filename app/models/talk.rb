class Talk < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :references, dependent: :destroy
  has_and_belongs_to_many :audiences

  validates :title, presence: true, length: { minimum: 3 }
  validates :slug, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :description, presence: true
  validates :deadline, presence: true
end
