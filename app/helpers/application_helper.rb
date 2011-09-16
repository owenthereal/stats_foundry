module ApplicationHelper
  def field_for(form, field, type, options = {})
    error_message = form.object.errors[field].first
    error_style = error_message.nil? ? "" : "error"

    input_field = content_tag(:div, :class => 'input') do
      html = form.send(type, field, :class => "xlarge #{error_style}")
      html += content_tag(:span, error_message, :class => 'help-inline') if error_message
      html
    end

    label_field = form.label(field) do
      field.to_s.titleize + mark_required(form.object, field)
    end

    content_tag(:div, :class => "clearfix #{error_style}") do
      label_field + input_field
    end
  end

  def mark_required(object, attribute)
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end
end
