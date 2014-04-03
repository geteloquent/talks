class ReferenceForm < BaseForm
  validates :url, presence: true, uniqueness: { scope: :talk_id }, \
    format: { with: URI.regexp, allow_blank: true }

  delegate_accessors :url, :talk_id, :talk, to: :record
  delegate :_destroy, to: :record

  def submit
    return false unless valid?

    record.save
  end

  private

  def target_class
    Reference
  end
end
