class SurveysController < ApplicationController
  before_action :search_user, only: %i[confirmation update]
  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      surveyMailer.new_subscriber(@survey).deliver_now
      redirect_to root_path, notice: { message: "Usuario creado", toast: :success }
    else
      redirect_to root_path, notice: { message: @survey.errors.full_messages.join(', '), toast: :error }
    end
  end

  def update
    if params[:survey_answered] == true
      @user.update(survey_answered: true)
      redirect_to new_survey_path
    else
      @user.update(survey_answered: false)
      redirect_to root_path, notice: "Thanks for subscribing"
    end
  end

  def confirmation
  end

  private

  def search_user
    @user = User.find(params["user_id"])
  end

  def survey_params
    params.require(:survey).permit(:id, :email, :survey_answered, preferences: [])
  end
end