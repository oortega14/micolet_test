class UserMailer < ApplicationMailer
  def new_subscriber(user)
    @user = user
    mail(to: user.email, subject: " Se ha subscrito satisfactoriamente a nuestra newsletter")
  end
end
