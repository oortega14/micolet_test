# frozen_string_literal: true

# method where deliver email to confirm subscription
class UserEmailJob < ApplicationJob
  queue_as :default
  
  def perform(user_id)
    @user = User.find(user_id)
    UserMailer.new_subscriber(@user).deliver_now
  end 
end