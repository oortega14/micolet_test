class User < ApplicationRecord
  validates :email, uniqueness: true

  has_many :answers, dependent: :destroy
  has_many :preferences, dependent: :destroy
  accepts_nested_attributes_for :preferences

end
