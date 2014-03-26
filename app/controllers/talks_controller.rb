class TalksController < ApplicationController
  before_action :set_talk, only: [:show]

  # GET /talks/:id
  def show
  end

  def slug_available
    render json: { status: Talk.exists?(slug: params[:slug]) }.to_json
  end

  def new
    @talk = Talk.new
    @talk.references.build
  end

  def create
    @talk = Talk.new(talk_params)
    params[:talk][:audience_ids].try(:each) { |id| @talk.audiences << Audience.find(id) }

    if @talk.save
      redirect_to @talk, notice: 'A palestra foi criada com sucesso.'
    else
      render action: 'new'
    end
  end

  private

    def talk_params
      params.require(:talk).permit(:title, :slug, :description, :deadline,
        audiences_attributes: [:name],
        references_attributes: [:url, :_destroy])
    end

    def set_talk
      @talk = Talk.friendly.find(params[:id])
    end
end
