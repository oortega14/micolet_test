# frozen_string_literal: true

# set the orm to use uuid
Rails.application.config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid
end
