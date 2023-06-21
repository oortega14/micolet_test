# frozen_string_literal: true

module Site
  # Controller for handling answers
  class AnswersController < BaseController
    before_action :set_survey, :set_user, only: %i[new]

    def new
      @answer = Answer.new
      @question = @questions.find_by(position: 1)
      @answering_survey = true
    end

    def create
      build_variables
      if @answer.save
        redirect_to_next_question
      else
        render :new
      end
    end

    def next
      @answering_survey = true
      @question = Question.find(params[:question_id])
      @user = User.find(params[:user_id])
      @answer = Answer.new
    end

    def end_page
      # Render de end_page to thanks users for answer surveys
    end

    def build_variables
      @answer = Answer.new(answer_params)
      @survey = @answer.question.survey
      @questions = @survey.questions
      @user = @answer.user
    end

    private

    def redirect_to_next_question
      next_question = @questions.where('position > ?', @answer.question.position).order(:position).first
      if next_question
        redirect_to next_site_answers_path(language: params[:locale], user_id: @user.id,
                                           question_id: next_question.id)
      else
        complete_survey
      end
    end

    def complete_survey
      @user.update(answer_survey: true)
      redirect_to end_page_site_answers_path(language: params[:locale]),
                  notice: { message: t('users.survey_completed'), toast: :success }
    end

    def set_survey
      @survey = Survey.find_by(language: params[:locale])
      @questions = @survey.questions
    end

    def set_user
      @user = User.find(params['user_id'])
    end

    def answer_params
      params.require(:answer).permit(:id, :answer, :user_id, :question_id)
    end
  end
end
