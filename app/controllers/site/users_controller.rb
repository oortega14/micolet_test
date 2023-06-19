module Site
  class UsersController < BaseController
    before_action :search_user, only: %i[survey]

    def new
      @user = User.new
      @user.preferences.build([
          { name: "#{t('main_page.preferences.first_option')}" },
          { name: "#{t('main_page.preferences.second_option')}" },
          { name: "#{t('main_page.preferences.third_option')}" },
          ])
    end

    def create
      @user = User.new(user_params)
      begin
        @user_verified = UserService.verify_email(@user)
        if @user_verified.email_verified && @user_verified.save!
          create_selected_preference
          UserMailer.new_subscriber(@user).deliver_now
          redirect_to confirmation_site_user_path(id: @user.id), notice: { message: t('users.created'), toast: :success }
        else
          redirect_to root_path, notice: { message: I18n.t('errors.email_rejected'), toast: :error }
        end
      rescue EmailVerificationError, ApiUnavailableError => e
        redirect_to root_path, notice: { message: e.message, toast: :error }
      rescue ActiveRecord::RecordInvalid => e
        redirect_to root_path, notice: { message: t('errors.email_repeated'), toast: :error }
      end
    end

    def survey
      if params["answer_survey"] == "true"
        redirect_to new_site_answer_path(user_id: @user.id, language: params[:locale])
      else
        @user.update(answer_survey: false)
        redirect_to root_path, notice: { message: t('users.subscribe'), toast: :success }
      end
    end

    def confirmation
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

    def search_user
      @user = User.find(params[:id])
    end

  end
end
