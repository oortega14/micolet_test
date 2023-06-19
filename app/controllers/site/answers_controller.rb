module Site
  class AnswersController < BaseController
    before_action :search_survey, only: %i[new]
    before_action :search_user, only: %i[new]

    def new
      @answer = Answer.new
      @question = @questions.find_by(position: 1)
    end

    def create
      @answer = Answer.new(answer_params)
      @survey = @answer.question.survey
      @questions = @survey.questions
      @user = @answer.user

      if @answer.save
        next_question = @questions.where("position > ?", @answer.question.position).order(:position).first
        if next_question
          redirect_to next_site_answers_path(language: params[:locale], user_id: @user.id, question_id: next_question.id)
        else
          redirect_to end_page_site_answers_path(language: params[:locale]), notice: 'Survey completed!'
        end
      else
        render :new
      end
    end

    def next
      @question = Question.find(params[:question_id])
      @user = User.find(params[:user_id])
      @answer = Answer.new
    end

    def end_page
    end

    private

    def search_survey
      @survey = Survey.find_by(language: params[:language])
      @questions = @survey.questions
    end

    def search_user
      @user = User.find(params["user_id"])
    end

    def answer_params
      params.require(:answer).permit(:id, :answer, :user_id, :question_id)
    end
  end
end
