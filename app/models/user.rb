# frozen_string_literal: true

# create_table 'users', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
#   t.string 'email'
#   t.boolean 'answer_survey'
#   t.boolean 'email_verified'
#   t.datetime 'created_at', null: false
#   t.datetime 'updated_at', null: false
# end

# Represents Users
class User < ApplicationRecord
  after_create :send_email
  after_initialize :build_preferences

  validates_presence_of :email
  validate :email_score_validation
  validates :email, uniqueness: true# { message: 'taken' }

  has_many :answers, dependent: :destroy
  has_many :preferences, dependent: :destroy
  accepts_nested_attributes_for :preferences

  private

  def email_score_validation
    valid_email = UserService.verify_email(self)
    self.errors.add(:base, I18n.t('errors.email_rejected')) unless valid_email
  end

  def send_email
    UserEmailJob.perform_later(self.id)
  end

  def build_preferences
    self.preferences.clear
    self.preferences.build([
                            { name: I18n.t('main_page.preferences.first_option') },
                            { name: I18n.t('main_page.preferences.second_option') },
                            { name: I18n.t('main_page.preferences.third_option') }
                          ])
  end
end
