module ApplicationHelper
  def field_for(form, field, type, options = {})
    error_message = form.object ? form.object.errors[field].first : nil
    error_style = error_message.nil? ? "" : "error"

    input_field = content_tag(:div, :class => 'input') do
      html = form.send(type, field, :class => "xlarge #{error_style}")
      html += content_tag(:span, error_message, :class => 'help-inline') if error_message
      html
    end

    label_field = form.label(field) do
      field.to_s.titleize
    end

    content_tag(:div, :class => "clearfix #{error_style}") do
      label_field + input_field
    end
  end

  def buttons(options = {})
    content_tag(:div, :class => "actions") do
      options.collect { |key, value| button_tag(value, :class => "btn #{key}") }.inject {|output, button_html| output += " "; output += button_html }
    end
  end

  def mark_required(object, attribute)
    " *" if object.present? && object.class.validators_on(attribute).map(&:class).include?(ActiveModel::Validations::PresenceValidator)
  end

  def alert_message(key, value)
    key = case key.to_s
          when 'alert' then 'error'
          when 'notice' then 'success'
          else key
          end
    content_tag(:div, :class => "alert-message #{key}") do
      link_to("x", "#", :class => "close") + content_tag(:p, content_tag(:strong, value))
    end
  end
end
