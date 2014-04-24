class TalksController < ApplicationController
  before_action :set_talk, only: [:show]

  def index
    condition = params[:status] == 'past' ? '<' : '>='
    ordering = params[:sort_by] == 'score' ? 'cached_votes_score DESC' : 'deadline ASC'

    @talks = Talk.page(params[:page]). \
      where("deadline #{condition} ?", Date.today).order(ordering). \
      includes(:audiences).decorate
  end

  # GET /talks/:id
  def show
  end

  def slug_available
    render json: { status: Talk.exists?(slug: params[:slug]) }.to_json
  end

  def new
    @talk = TalkForm.new
    @talk.build_reference
  end

  def create
    @talk = TalkForm.new(talk_params)

    if @talk.submit
      redirect_to @talk.record, notice: 'A palestra foi criada com sucesso.'
    else
      @talk.build_reference if @talk.references.empty?
      flash[:alert] = 'A palestra não pode ser salva.'
      render action: 'new'
    end
  end

  private

    def talk_params
      params.require(:talk).permit(:title, :slug, :description, :deadline,
        audience_ids: [],
        nested_audiences_attributes: [:name, :_destroy],
        references_attributes: [:url, :_destroy])
    end

    def set_talk
      @talk = Talk.friendly.find(params[:id]).decorate
    end
end
