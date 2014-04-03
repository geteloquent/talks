class TalkForm < BaseForm
  validates :title, presence: true, length: { minimum: 3, allow_blank: true }
  validates :slug, presence: true, length: { minimum: 3, allow_blank: true },
    uniqueness: true
  validates :description, presence: true
  validates :deadline, presence: true,
    timeliness: { on_or_after: lambda { Date.current }, allow_blank: true }
  validates :audiences, length: { minimum: 1 }

  delegate_accessors :title, :slug, :description, :deadline, :references,
    :audiences, :audience_ids, to: :record

  class << self
    delegate :model_name, to: Talk
  end

  def build_reference
    record.references.build
  end

  def submit
    return false unless valid?

    ActiveRecord::Base.transaction do
      record.save if save_nested
    end
  end

  def nested_audiences_attributes=(attributes)
    audiences = attributes.values
    audiences.reject! { |r| r[:name].blank? }
    audiences.reject! { |r| r.delete(:_destroy) == "1" }

    record.audiences << audiences.collect { |r| Audience.new(r) }
  end

  def references_attributes=(attributes)
    references = attributes.values
    references.reject! { |r| r[:url].blank? }
    references.reject! { |r| r.delete(:_destroy) == "1" }

    record.references << references.collect { |r| Reference.new(r) }
  end

  def nested_audiences
    record.audiences.select { |a| a.new_record? }
  end

  private

  def target_class
    Talk
  end

  def save_nested
    all_saved = (record.audiences.map(&:save) + \
      record.references.map(&:save)).reduce(:&)
    raise ActiveRecord::Rollback unless all_saved

    all_saved
  end
end
