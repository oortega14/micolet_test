# frozen_string_literal: true

module Site
  # Controller for handling users
  class UsersController < BaseController
    before_action :set_user, only: %i[survey]

    def index
      @user = User.new
      build_preferences(@user)
      render :new
    end

    def new
      @user = User.new
      build_preferences(@user)
    end

    def create
      @user = User.new(depured_user_params)
      if @user.save!
        redirect_to confirmation_site_user_path(id: @user.id),
                    notice: { message: t('users.created'), toast: :success }
      end
    rescue EmailVerificationError, ApiUnavailableError, ActiveRecord::RecordInvalid => e
      @user.preferences.clear
      build_preferences(@user)
      render :new, status: :bad_request
    end

    def survey
      if params['answer_survey'] == 'true'
        redirect_to new_site_answer_path(user_id: @user.id, language: params[:locale])
      else
        @user.update(answer_survey: false)
        redirect_to site_root_path, notice: { message: t('users.subscribe'), toast: :success }
      end
    end

    def confirmation
      # Render confirmation view for new users
    end

    private

    def depured_user_params
      new_params = params[:user][:preferences_attributes].reject! { |_, value| value["name"] == "0" }
      new_params = params.require(:user)
                         .permit(:id, :email, :answer_survey, :email_verified,
                                 preferences_attributes: %i[id name internal_key user_id])
      new_params
    end

    def set_user
      @user = User.find(params[:id])
    end

    def build_preferences(user)
      user.preferences.build([
                              { name: I18n.t('main_page.preferences.first_option') },
                              { name: I18n.t('main_page.preferences.second_option') },
                              { name: I18n.t('main_page.preferences.third_option') }
                            ])
    end
  end
end
