class AudienceTalk < ActiveRecord::Base
  belongs_to :talk
  belongs_to :audience
end
