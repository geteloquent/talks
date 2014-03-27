module ApplicationHelper

  def errors_for(object, method)
    errors = object.errors[method].collect do |msg|
      content_tag(:li, msg)
    end.join.html_safe

    content_tag(:ul, errors, :class => 'text-error') unless object.errors.empty?
  end

end
