class TalksController < ApplicationController
  def slug_available
    render json: { status: Talk.exists?(slug: params[:slug]) }.to_json
  end

  def new
    @talk = Talk.new
  end

  def create
    @talk = Talk.new(talk_params)

    if @talk.save
      redirect_to action: 'new', notice: 'A palestra foi criada com sucesso.'
    else
      render action: 'new'
    end
  end

  private

    def talk_params
      params.require(:talk).permit(:title, :slug, :description, :deadline)
    end
end
