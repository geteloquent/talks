class VotesController < ApplicationController
  def create
    talk = Talk.friendly.find(params[:talk_id])
    TalkVoting.new(talk).vote(User.anonymous, params[:vote])
    redirect_to talk, notice: "Seu voto foi computado com sucesso!"
  end
end
