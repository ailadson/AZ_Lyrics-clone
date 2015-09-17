module ApplicationHelper

  def auth_token
    auth = <<-HTML
      <input type='hidden'
             name='authenticity_token'
             value=#{form_authenticity_token} >
    HTML

    auth.html_safe
  end

end
