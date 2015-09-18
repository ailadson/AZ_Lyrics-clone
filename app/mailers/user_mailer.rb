class UserMailer < ApplicationMailer
  default from: 'admin@lame-azlyric.com'

  def activation_email(user)
    @user = user
    mail(to: user.email, subject: 'Activate Account')
  end

end
