module ApplicationHelper
  def message_change(msg)
    case msg
    when "notice"
      msg = "success"
    when "alert", "error"
      msg = "danger"
    else
      msg = msg
    end
  end
end
