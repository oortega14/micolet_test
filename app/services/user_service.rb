# frozen_string_literal: true

# Call an external API to verify if the entered email exists and return true or false
class UserService < ApplicationService
  def self.verify_email(user)
    abstract_api_url = "#{ENV['ABSTRACT_API_URL']}?api_key=#{ENV['ABSTRACT_API_KEY']}&email=#{user.email}"

    response = Faraday.get(abstract_api_url)
    raise ApiUnavailableError, I18n.t('errors.api') unless response.success?

    body = JSON.parse(response.body)
    result = body['quality_score'].to_f
    result > 0.7
  end
end
