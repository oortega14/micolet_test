class SurveysController < ApplicationController
  before_action :search_user, only: %i[confirmation update]
  def new
    @survey = Survey.new
    @questions = Question.order(created_at: :asc).all
  end

  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      @survey.update(completed: true)
      redirect_to root_path, notice: 'Encuesta completada exitosamente'
    else
      render :new
    end
  end

  def update
    if params["survey_answered"] == "true"
      @user.update(survey_answered: true)
      redirect_to new_survey_path
    else
      @user.update(survey_answered: false)
      redirect_to root_path, notice: "Thanks for subscribing"
    end
  end

  def question
    @question = Question.find(params[:question_id])
    render json: { nextQuestionUUID: @question.id, questionHTML: render_to_string(partial: 'question', locals: { question: @question }) }
  end

  def next_question
    current_question_uuid = params[:uuid]
    current_question = Question.find_by(id: current_question_uuid)
  
    if current_question.nil?
      render json: { error: 'Pregunta no encontrada' }, status: :not_found
      return
    end
  
    next_question = Question.where('created_at > ?', current_question.created_at).order(:created_at).first

    if next_question.nil?
      render json: { error: 'No hay más preguntas' }, status: :not_found
      return
    end
  
    render json: { nextQuestionUUID: next_question.id, questionHTML: render_to_string(partial: 'question', locals: { question: next_question }), defaultNextQuestionUUID: "default" }
  end

  def confirmation
  end

  private

  def search_user
    @user = User.find(params["user_id"])
  end

  def survey_params
    params.require(:survey).permit(survey_questions_attributes: %i[question_id answer])
  end
end
