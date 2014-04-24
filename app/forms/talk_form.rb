class TalkForm < BaseForm
  validates :title, presence: true, length: { minimum: 3, allow_blank: true }
  validates :slug, presence: true, length: { minimum: 3, allow_blank: true },
    uniqueness: true
  validates :description, presence: true
  validates :deadline, presence: true,
    timeliness: { on_or_after: lambda { Date.current }, allow_blank: true }
  validates :audiences, length: { minimum: 1 }
  validates :user_id, presence: true

  delegate_accessors :title, :slug, :description, :deadline, :audience_ids, \
    :user_id, to: :record

  class << self
    delegate :model_name, to: Talk
  end

  def initialize(attributes = {})
    @references_forms = []
    @audiences_forms = []
    super
  end

  def audiences
    @audiences_forms.map(&:record) + record.audiences
  end

  def nested_audiences
    @audiences_forms
  end

  def references
    @references_forms
  end

  def build_reference
    @references_forms << ReferenceForm.new
  end

  def submit
    return false unless valid?

    ActiveRecord::Base.transaction do
      record.save
      save_nested
    end
  end

  def nested_audiences_attributes=(attributes)
    audiences = attributes.values
    audiences.reject! { |r| r[:name].blank? }
    audiences.reject! { |r| r.delete(:_destroy) == "1" }

    @audiences_forms = audiences.collect { |r| AudienceForm.new(r) }
  end

  def references_attributes=(attributes)
    references = attributes.values
    references.reject! { |r| r[:url].blank? }
    references.reject! { |r| r.delete(:_destroy) == "1" }

    @references_forms = references.collect { |r| ReferenceForm.new(r) }
  end

  private

  def target_class
    Talk
  end

  def save_nested
    @references_forms.each { |r| r.talk = record }

    all_saved = (@audiences_forms.map(&:submit) + \
      @references_forms.map(&:submit)).reduce(true, :&)
    raise ActiveRecord::Rollback unless all_saved

    record.audiences << @audiences_forms.map { |a| a.record }
    all_saved
  end
end
