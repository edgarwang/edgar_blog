module ApplicationHelper
  def site_title
    Settings.site_title
  end

  def disqus_shortname
    Settings.disqus_shortname
  end

  def attachments_page?
    controller_name == 'attachments'
  end

  def trashes_page?
    controller_name == 'articles' && action_name == 'trash'
  end

  def articles_page?
    controller_name == 'articles' && action_name == 'index'
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
