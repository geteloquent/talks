class Reference < ActiveRecord::Base
  belongs_to :talk

  validates :url, presence: true,
    format: { with: URI.regexp, allow_blank: true },
    uniqueness: { scope: :talk_id, case_sensitive: false }
end
