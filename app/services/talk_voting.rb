class TalkVoting
  def initialize(talk)
    @talk = talk
  end

  def vote(voter, vote)
    @talk.vote voter: voter, vote: vote, duplicate: true
  end
end
