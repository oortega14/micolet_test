# frozen_string_literal: true

require 'faraday'
require 'json'

# verify Email exists
class UserService
  ABSTRACT_API_URL = 'https://emailvalidation.abstractapi.com/v1/'

  def self.verify_email(user)
    conn = Faraday.new(url: ABSTRACT_API_URL)
    response = conn.get do |req|
      req.params['api_key'] = 'b40e796a91ee4a0ba322d0d96bdd04b9'
      req.params['email'] = user.email
    end
    raise ApiUnavailableError, I18n.t('errors.api') unless response.success?

    body = JSON.parse(response.body)
    result = body['quality_score'].to_f
    if result > 0.7
      user.email_verified = true
    else
      user.email_verified = false
      raise EmailVerificationError, I18n.t('errors.email_rejected')
    end

    user
  end
end
