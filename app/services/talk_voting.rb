class TalkVoting
  def initialize(talk)
    @talk = talk
  end

  def score
    @talk.likes.size - @talk.dislikes.size
  end

  def vote(voter, vote)
    @talk.vote voter: voter, vote: vote, duplicate: true
  end
end
