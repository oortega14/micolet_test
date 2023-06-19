class SurveysController < ApplicationController
  before_action :search_user, only: %i[confirmation update]

  def update
    if params["answer_survey"] == "true"
      @user.update(answer_survey: true)
      redirect_to new_answer_path(user_id: @user.id, language: 'es')
    else
      @user.update(answer_survey: false)
      redirect_to root_path, notice: "Thanks for subscribing"
    end
  end

  def confirmation
  end

  private

  def search_user
    @user = User.find(params["user_id"])
  end
end
