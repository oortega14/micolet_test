# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    before(:each) do
      allow(UserService).to receive(:verify_email).and_return(true)
    end
    subject(:user) { described_class.new(email: 'algo@sample.com') }

    it 'valida la unicidad del email' do
      expect(user).to validate_uniqueness_of(:email)
    end
  end

  describe 'associations' do
    it { should have_many(:answers).dependent(:destroy) }
    it { should have_many(:preferences).dependent(:destroy) }
    it { should accept_nested_attributes_for(:preferences) }
  end

  describe 'callbacks' do
    before(:each) do
      allow(UserService).to receive(:verify_email).and_return(true)
    end
    it 'triggers send_email after create' do
      user = User.new(email: 'test@example.com')
      expect(user).to receive(:send_email)
      user.save
    end
  end

  describe 'methods' do
    describe '#email_score_validation' do
      it 'adds an error if email is not valid' do
        user = User.new(email: 'invalid_email')
        allow(UserService).to receive(:verify_email).and_return(false)
        user.valid?
        expect(user.errors[:base]).to include(I18n.t('errors.email_rejected'))
      end

      it 'does not add an error if email is valid' do
        user = User.new(email: 'valid_email@example.com')
        allow(UserService).to receive(:verify_email).and_return(true)
        user.valid?
        expect(user.errors[:base]).not_to include(I18n.t('errors.email_rejected'))
      end
    end
  end
end
