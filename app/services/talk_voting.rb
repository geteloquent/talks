class TalkVoting
  def initialize(talk, voter, vote)
    @talk = talk
    @voter = voter
    @vote = vote
  end

  def vote
    if @voter.anonymous?
      @talk.vote voter: @voter, vote: @vote, duplicate: true
    else
      @talk.send("#{@vote}d_by", @voter)
    end
  end

  def notice
    if /un/.match @vote
      "Seu voto foi removido."
    else
      "Seu voto foi computado."
    end
  end
end
