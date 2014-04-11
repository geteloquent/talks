class Talk < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_votable

  has_many :references, dependent: :destroy
  has_and_belongs_to_many :audiences

  def voting_score
    self.likes.size - self.dislikes.size
  end
end
