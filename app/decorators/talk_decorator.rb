class TalkDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate :title, :slug, :description, :audiences, :references, \
    :voting_score

  def deadline
    l(model.deadline)
  end

  def path
    "#{talks_url}/#{slug}"
  end

  def score
    TalkVoting.new(model).score
  end
end
