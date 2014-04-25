class VotesController < ApplicationController
  def create
    talk = Talk.friendly.find(params[:talk_id])
    user = current_user || User.anonymous
    service = TalkVoting.new(talk, user, params[:vote])
    service.vote

    redirect_to talk, notice: service.notice
  end
end
