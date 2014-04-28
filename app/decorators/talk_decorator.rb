class TalkDecorator < ApplicationDecorator
  include Draper::LazyHelpers

  delegate :title, :slug, :description, :audiences, :references, \
    :cached_votes_score, :user, :id

  def deadline
    l(model.deadline)
  end

  def path
    "#{talks_url}/#{slug}"
  end

  def vote_active_class(vote)
    "active" if current_user_voted?(vote)
  end

  def vote_value(vote)
    prefix = "un" if current_user_voted?(vote)
    "#{prefix}#{vote}"
  end

  private

  def current_user_voted?(vote)
    current_user && current_user.send("#{vote}d?", object)
  end
end
