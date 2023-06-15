class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Usuario registrado exitosamente'
      redirect_to new_user_path
    else
      flash[:error] = 'Usuario no registrado'
      redirect_to new_user_path
    end
  end

  def edit
  end
  def update
  end
  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :survey_answered, preferences: [])
  end
end