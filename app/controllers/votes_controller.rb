class VotesController < ApplicationController
  def create
    talk = Talk.friendly.find(params[:talk_id])
    talk.vote voter: User.anonymous, vote: params.key?(:like), duplicate: true
    redirect_to talk, notice: "Seu voto foi computado com sucesso!"
  end
end
