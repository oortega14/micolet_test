# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'validates presence and uniqueness of email' do
      user = FactoryBot.build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include(I18n.t('activerecord.errors.messages.blank'))

      FactoryBot.create(:user, email: 'example@example.com')
      user = FactoryBot.build(:user, email: 'example@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include(I18n.t('activerecord.errors.messages.taken'))
    end
  end

  describe 'associations' do
    it 'has many answers' do
      user = FactoryBot.create(:user)
      answer1 = FactoryBot.create(:answer, user:)
      answer2 = FactoryBot.create(:answer, user:)

      expect(user.answers).to include(answer1, answer2)
    end

    it 'has many preferences' do
      user = FactoryBot.create(:user)
      preference1 = FactoryBot.create(:preference, user:)
      preference2 = FactoryBot.create(:preference, user:)

      expect(user.preferences).to include(preference1, preference2)
    end

    it 'accepts nested attributes for preferences' do
      user = User.new(preferences_attributes: [{ name: 'Preference 1' }, { name: 'Preference 2' }])
      expect(user.preferences.size).to eq(2)
      expect(user.preferences.first.name).to eq('Preference 1')
      expect(user.preferences.last.name).to eq('Preference 2')
    end
  end
end
