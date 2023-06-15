class User < ApplicationRecord
  validates :email, uniqueness: true

  has_one :survey
end
