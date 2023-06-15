module ApplicationHelper
  def flash_class(key)
    case key.to_sym
    when :notice, :success
      'flash-success'
    when :alert, :error
      'flash-error'
    else
      'flash-default'
    end
  end
end
