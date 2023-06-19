# frozen_string_literal: true

# Helper for all user methods
class UserMailer < ApplicationMailer
  def new_subscriber(user)
    @user = user
    mail(to: user.email, subject: I18n.t('users.email.subject'))
  end
end
