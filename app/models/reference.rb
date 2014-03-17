class Reference < ActiveRecord::Base
  belongs_to :talk

  validates :url, presence: true, format: { with: URI.regexp }
end
