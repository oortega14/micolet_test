# frozen_string_literal: true

# Represents Users
class User < ApplicationRecord
  validates_presence_of :email
  validates :email, uniqueness: { message: I18n.t('activerecord.errors.messages.taken') }

  has_many :answers, dependent: :destroy
  has_many :preferences, dependent: :destroy
  accepts_nested_attributes_for :preferences
end
