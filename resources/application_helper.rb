module ApplicationHelper

  def format_error_messages(object, message=nil)
    html = ""
    unless object.errors.blank?
      html << "<div class='errorExplanation #{object.class.name.humanize.downcase}Errors'>\n"
      action_name = object.new_record? ? "creating" : "updating"
      if message.blank?
        html << "\t\t<h2>There was a problem #{action_name} the #{object.class.name.humanize.downcase}</h2>\n"
      else
        html << "<h2>#{message}</h2>"
      end  
      html << "\t\t<ul>\n"
      object.errors.full_messages.each do |error|
        html << "\t\t\t<li>#{error}</li>\n"
      end
      html << "\t\t</ul>\n"
      html << "\t</div>\n"
    end
    html.html_safe
  end

  def flashy
    f_names = [:notice, :error, :warning, :message, :success]
    fl = ''

    for name in f_names
      if flash[name]
        fl = fl + "<div class=\"flash #{name}\">#{flash[name]}</div>"
      end
      flash[name] = nil;
    end
    return fl.html_safe
  end
  
end