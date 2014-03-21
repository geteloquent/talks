class Talk < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :references, dependent: :destroy
  accepts_nested_attributes_for :references, allow_destroy: true, reject_if: proc { |a| a['url'].blank? }
  has_many :audience_talks
  has_many :audiences, through: :audience_talks
  accepts_nested_attributes_for :audiences, reject_if: proc { |a| a['name'].blank? }

  validates :title, presence: true, length: { minimum: 3 }
  validates :slug, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :description, presence: true
  validates :deadline, presence: true, timeliness: { on_or_after: lambda { Date.current } }
  validates :audiences, presence: true
end
