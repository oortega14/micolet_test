class SurveyQuestionsController < ApplicationController
  def new

  end

  def create
    question_id = params["question_id"]
    answer_text = params["answer"]
    @questions = Question.all.size
    SurveyQuestion.create!(question_id: question_id, answer: answer_text)
    answers = SurveyQuestion.all.size

    if answers == @questions
      @survey = Survey.create(completed: true)
      if @survey.save
        @answers = SurveyQuestion.last(@questions)
        @answers.each do |answer|
          answer.update(survey_id: @survey.id)
        end
        redirect_to survey_completed_path # Página de encuesta completada o a donde corresponda
      else
        redirect_to new_survey_path
      end
    end
  end
end
