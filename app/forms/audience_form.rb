class AudienceForm < BaseForm
  delegate_accessors :name, to: :record
  delegate :_destroy, to: :record

  validates :name, presence: true, uniqueness: true

  def submit
    return false unless valid?

    record.save
  end

  private

  def target_class
    Audience
  end
end
