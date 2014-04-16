class TalkDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate :title, :slug, :description, :audiences, :references, \
    :cached_votes_score

  def deadline
    l(model.deadline)
  end

  def path
    "#{talks_url}/#{slug}"
  end
end
