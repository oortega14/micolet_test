class User < ApplicationRecord
  validates :email, uniqueness: { message: I18n.t('activerecord.errors.messages.taken') }

  has_many :answers, dependent: :destroy
  has_many :preferences, dependent: :destroy
  accepts_nested_attributes_for :preferences

end
