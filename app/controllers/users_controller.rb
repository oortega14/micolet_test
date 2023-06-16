class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.new_subscriber(@user).deliver_now
      redirect_to root_path, notice: { message: "Usuario creado", toast: :success }
    else
      redirect_to root_path, notice: { message: @user.errors.full_messages.join(', '), toast: :error }
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :survey_answered, preferences: [])
  end
end