module ApplicationHelper
  def format_error_messages(errors)
    result = ""
    unless errors.empty?
      result ="<div class='error'>"
      errors.each do |e|
        result+= "<li>#{e}</li>"
      end
      result+= "</div>"
    end
    result
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