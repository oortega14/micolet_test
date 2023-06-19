# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe 'associations' do
    it { should have_many(:questions) }
  end
end
