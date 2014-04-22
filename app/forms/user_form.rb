class UserForm < BaseForm
  delegate_accessors :email, :name, :username, :avatar_url, to: :record
  delegate :new_record?, :id, to: :record

  validates_presence_of :name, :email, :username, :avatar_url

  def submit
    return false unless valid?
    record.save
  end

  def initialize(params)
    @record = target_class.find_by_email(params[:email])
    super(params)
  end

  def target_class
    User
  end
end
