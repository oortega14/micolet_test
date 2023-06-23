# frozen_string_literal: true

require 'rails_helper'
require 'support/webmock'

# Especificaciones de RSpec
RSpec.describe Site::AnswersController, type: :controller do
  describe "GET new" do
    let(:survey) { create(:survey) }
    let(:user) { create(:user) }

    before do
      allow(Survey).to receive(:find_by).and_return(survey)
      allow_any_instance_of(Site::AnswersController).to receive(:set_user)
      get :new, params: { locale: 'es', user_id: user.id }
    end

    it "assigns a new answer" do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it "assigns the first question to @question" do
      expect(assigns(:question)).to eq(survey.questions.find_by(position: 1))
    end

    it "sets @answering_survey to true" do
      expect(assigns(:answering_survey)).to be true
    end

    it "renders the new template" do
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    let(:user) { create(:user) }
    let(:survey) { create(:survey) }
    let(:question) { create(:question, survey: survey) }
    let(:answer_params) { { answer: "My answer", user_id: user.id, question_id: question.id } }

    before do
      allow(controller).to receive(:set_survey)
      allow(controller).to receive(:set_user)
      allow(controller).to receive(:redirect_to_next_question)  
      allow(controller).to receive(:complete_survey)  
    end

    it "creates a new answer" do
      expect {
        post :create, params: { answer: answer_params, locale: 'en' }
      }.to change { Answer.count }.by(1)
    end

    it "renders the 'new' template if answer is not saved" do
      allow_any_instance_of(Answer).to receive(:save).and_return(false)  # Simular que el guardado falla

      post :create, params: { answer: answer_params, locale: 'en' }

      expect(response).to render_template(:new)
    end
  end

  describe "GET next" do
    let(:user) { create(:user) }
    let(:question) { create(:question) }

    before do
      allow(Question).to receive(:find).and_return(question)
      allow(User).to receive(:find).and_return(user)
      get :next, params: { question_id: question.id, user_id: user.id, locale: 'en' }
    end

    it "assigns the necessary variables" do
      expect(assigns(:answering_survey)).to be_truthy
      expect(assigns(:question)).to eq(question)
      expect(assigns(:user)).to eq(user)
      expect(assigns(:answer)).to be_a_new(Answer)
    end

  end

  describe "GET end_page" do
    let(:user) { create(:user) }

    before do
      allow(User).to receive(:find).and_return(user)
      get :end_page, params: { locale: 'en' }
    end

    it "renders the end_page template" do
      expect(response).to render_template("end_page")
    end

    it "returns a successful response" do
      expect(response).to have_http_status(:success)
    end
  end
end
