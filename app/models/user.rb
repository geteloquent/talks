class User < ActiveRecord::Base
  acts_as_voter

  def self.anonymous
    create_with(name: "Anônimo", email: "anonimo@elotalks.com"). \
      find_or_create_by(username: "anonimo")
  end
end
