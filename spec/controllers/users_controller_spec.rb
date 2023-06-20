require 'rails_helper'

# Especificaciones de RSpec
RSpec.describe Site::UsersController, type: :controller do
  describe "GET #new" do
    it "assigns a new User to @user" do
      get :new, params: { locale: 'es' }
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the new template" do
      get :new, params: { locale: 'es' }
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          user: {
            name: "John Doe",
            email: "johndoe@example.com",
            preferences_attributes: {"0"=>{"name"=>"Women's Fashion"}, "1"=>{"name"=>"0"}, "2"=>{"name"=>"0"}}
            # Otros atributos necesarios
          },
          locale: 'es'
        }
      end

      before(:each) do
        allow(UserService).to receive(:verify_email).and_return(true)
      end

      it "creates a new User" do
        expect {
          post :create, params: valid_params, body: valid_params
        }.to change(User, :count).by(1)
      end

      it "redirects to the confirmation page" do
        post :create, params: valid_params
        expect(response).to redirect_to(confirmation_site_user_path(id: User.last.id))
      end

      it "sets the notice message" do
        post :create, params: valid_params
        expect(flash[:notice][:message]).to eq(I18n.t('users.created'))
      end

      it "sets the notice toast to :success" do
        post :create, params: valid_params
        expect(flash[:notice][:toast]).to eq(:success)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          user: {
            name: "John Doe",
            email: "",
            preferences_attributes: {"0"=>{"name"=>"Women's Fashion"}, "1"=>{"name"=>"0"}, "2"=>{"name"=>"0"}}
          },
          locale: 'es'
        }
      end

      before(:each) do
        allow(UserService).to receive(:verify_email).and_return(false)
      end

      it "does not create a new User" do
        expect {
          post :create, params: invalid_params
        }.not_to change(User, :count)
      end

      it "builds user preferences" do
        post :create, params: invalid_params
        expect(assigns(:user).preferences).not_to be_nil
      end

      it "redirects to the new page" do
        post :create, params: invalid_params
        expect(response).to redirect_to(new_site_user_path)
      end
    end
  end

  describe "GET #survey" do
    context "when answer_survey is true" do
      before(:each) do
        allow(UserService).to receive(:verify_email).and_return(true)
      end
      it "redirects to the new answer path" do
        user = FactoryBot.create(:user)
        post :survey, params: { answer_survey: 'true', locale: 'en', id: user.id }
        expect(response).to redirect_to(new_site_answer_path(user_id: user.id, language: 'en'))
      end
    end
    
    context "when answer_survey is false" do
      before(:each) do
        allow(UserService).to receive(:verify_email).and_return(true)
      end
      it "updates answer_survey attribute to false" do
        user = FactoryBot.create(:user)
        post :survey, params: { answer_survey: 'false', locale: 'en', id: user.id }
        user.reload
        expect(user.answer_survey).to eq(false)
      end
      
      it "redirects to the root path" do
        user = FactoryBot.create(:user)
        post :survey, params: { answer_survey: 'false', locale: 'en', id: user.id }
        expect(response).to redirect_to(root_path)
      end
      
      it "sets the notice message" do
        user = FactoryBot.create(:user)
        post :survey, params: { answer_survey: 'false', locale: 'en', id: user.id }
        expect(flash[:notice][:message]).to eq(I18n.t('users.subscribe'))
      end
      
      it "sets the notice toast to :success" do
        user = FactoryBot.create(:user)
        post :survey, params: { answer_survey: 'false', locale: 'en', id: user.id }
        expect(flash[:notice][:toast]).to eq(:success)
      end
    end
  end

  describe "GET #confirmation" do
    before(:each) do
      allow(UserService).to receive(:verify_email).and_return(true)
    end
    it "renders the confirmation template" do
      user = FactoryBot.create(:user)
      get :confirmation, params: { id: user.id, locale: 'es'}
      expect(response).to render_template(:confirmation)
    end
  end
end