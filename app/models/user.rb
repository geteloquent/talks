class User < ActiveRecord::Base
  has_many :talks

  acts_as_voter

  def self.anonymous
    find_or_create_by(username: "anonimo") do |user|
      user.name = "Anônimo"
      user.email = "anonimo@elotalks.com"
    end
  end
end
