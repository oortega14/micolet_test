# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Site::AnswersController, type: :controller do
  describe 'GET #new' do
    let(:survey) { create(:survey) }
    let(:user) { create(:user) }
    let(:questions) { create_list(:question, 5, survey:) }

    before do
      allow(controller).to receive(:search_survey).and_return(true)
      allow(controller).to receive(:search_user).and_return(true)
      allow(controller).to receive(:params).and_return({ locale: 'en', user_id: user.id })
      @questions = questions

      get :new, params: { locale: 'en' }
    end

    it 'assigns @questions' do
      expect(assigns(:questions)).to eq(questions)
    end

    it 'assigns a new Answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'assigns the first question' do
      expect(assigns(:question)).to eq(questions.first)
    end

    it 'sets answering_survey to true' do
      expect(assigns(:answering_survey)).to be true
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:survey) { create(:survey) }
    let(:user) { create(:user) }
    let(:questions) { create_list(:question, 5, survey:) }
    let(:answer_params) { attributes_for(:answer, user_id: user.id, question_id: questions.first.id) }

    before do
      allow(controller).to receive(:params).and_return({ locale: 'en', user_id: user.id })
      allow(controller).to receive(:@survey).and_return(survey)
      allow(controller).to receive(:@questions).and_return(questions)
      allow(controller).to receive(:@user).and_return(user)
    end

    context 'when answer is valid' do
      it 'creates a new answer' do
        expect do
          post :create, params: { answer: answer_params }
        end.to change(Answer, :count).by(1)
      end

      it 'redirects to the next question' do
        post :create, params: { answer: answer_params }
        expect(response).to redirect_to(next_site_answers_path(language: 'en', user_id: user.id,
                                                               question_id: questions.second.id))
      end
    end

    context 'when answer is invalid' do
      let(:invalid_answer_params) { attributes_for(:answer, user_id: user.id, question_id: nil) }

      it 'does not create a new answer' do
        expect do
          post :create, params: { answer: invalid_answer_params }
        end.not_to change(Answer, :count)
      end

      it 'renders the new template' do
        post :create, params: { answer: invalid_answer_params }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #next' do
    let(:question) { create(:question) }
    let(:user) { create(:user) }

    before do
      allow(controller).to receive(:params).and_return({ question_id: question.id, user_id: user.id })
      get :next
    end

    it 'sets answering_survey to true' do
      expect(assigns(:answering_survey)).to be true
    end

    it 'assigns the specified question' do
      expect(assigns(:question)).to eq(question)
    end

    it 'assigns the specified user' do
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns a new Answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #end_page' do
    before do
      get :end_page
    end

    it 'renders the end_page template' do
      expect(response).to render_template(:end_page)
    end
  end
end
