class UserForm < BaseForm
  delegate_accessors :email, :name, :username, :avatar_url, :github_uid, \
    to: :record
  delegate :new_record?, :id, to: :record

  validates_presence_of :name, :email, :username, :avatar_url, :github_uid

  validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates :github_uid, uniqueness: true

  def submit
    return false unless valid?
    record.save
  end

  def initialize(params)
    @record = target_class.find_by(github_uid: params[:github_uid])
    super(params)
  end

  private

  def target_class
    User
  end
end
