class User < ActiveRecord::Base
  has_many :talks, dependent: :destroy

  acts_as_voter

  ANONYMOUS_USERNAME = "anonimo"

  def self.anonymous
    find_or_create_by(username: ANONYMOUS_USERNAME) do |user|
      user.name = "Anônimo"
      user.email = "anonimo@elotalks.com"
    end
  end

  def anonymous?
    self.username == ANONYMOUS_USERNAME
  end
end
