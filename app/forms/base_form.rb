class BaseForm
  include ActiveModel::Model
  include DelegateAccessors

  def uniq?(conditions)
    relation = target_class.where(conditions)
    if record.persisted?
      table_name = record.class.to_s.tableize
      relation = relation.where("#{table_name}.id != ?", record.id)
    end
    ! relation.exists?
  end

  def record
    @record ||= target_class.new
  end
end

class UniquenessValidator < ActiveModel::EachValidator
  # validate :attribute, uniqueness: { scope: :scope_attribute }
  def initialize(args)
    super
    @scope = args.fetch(:scope, {})
  end

  def validate_each(record, attribute, value)
    scope = {}
    scope = { @scope => record.public_send(@scope) } unless @scope.empty?

    unless record.uniq?(scope.merge(attribute => value))
      record.errors.add(attribute, :taken)
    end
  end
end
