module ApplicationHelper
  def site_title
    Settings.site_title
  end

  # Get html tag's class from flash's key
  # value for message showing
  def class_type_for_message(key)
    case key
    when :success
      return 'success'
    when :notice
      return 'info'
    when :alert
      return 'warning'
    when :error
      return 'error'
    else
      return 'info'
    end
  end
end
