class UsersController < ApplicationController
  def new
    @user = User.new
    @user.preferences.build([
        { name: "Women's Fashion" },
        { name: "Men's Fashion" },
        { name: "Children's Fashion" },
        ])
  end

  def create
    @user = User.new(user_params)
    @user_verified = UserService.verify_email(@user)
    if @user_verified.email_verified && @user_verified.save
      create_selected_preference
      UserMailer.new_subscriber(@user).deliver_now
      redirect_to confirmation_surveys_path(user_id: @user.id), notice: { message: "Usuario creado", toast: :success }
    else
      redirect_to root_path, notice: { message: @user.errors.full_messages.join(', '), toast: :error }
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :answer_survey, :email_verified, preferences_attributes: %i[id name internal_key user_id])
  end

  def create_selected_preference
    selected_preferences = params[:user][:preferences_attributes].values
    selected_preferences.reject! { |preference| preference["name"] == "0" }
    return if selected_preferences.blank?

    @user.preferences.destroy_all
    selected_preferences.each do |preference_params|
      @user.preferences.create(preference_params)
    end
  end

end