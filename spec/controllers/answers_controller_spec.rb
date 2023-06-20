# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Site::AnswersController, type: :controller do
  describe 'GET #new' do
    let(:survey) { create(:survey) }
    let(:user) { create(:user) }
    let(:questions) { create_list(:question, 5) }

    before do
      allow(controller).to receive(:set_survey)
      allow(controller).to receive(:set_user)
      allow(controller).to receive(:params).and_return({})
      allow(Question).to receive(:find_by).and_return(questions.first)
    end

    it 'assigns a new Answer to @answer' do
      get :new, params: { locale: 'es' }
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'assigns the first question' do
      get :new, params: { locale: 'es' }
      expect(assigns(:question)).to eq(questions.first)
    end

    it 'sets answering_survey to true' do
      get :new, params: { locale: 'es' }
      expect(assigns(:answering_survey)).to be_truthy
    end
  end
end
