require 'faraday'
require 'json'

class UserService
  ABSTRACT_API_URL = 'https://emailvalidation.abstractapi.com/v1/'

  def self.verify_email(user)
    conn = Faraday.new(url: ABSTRACT_API_URL)
    response = conn.get do |req|
      req.params['api_key'] = 'ab429fe1eae24825bb3b2551c78922a3'
      req.params['email'] = user.email
    end

    if response.success?
      body = JSON.parse(response.body)
      result = body["quality_score"].to_f
      if result > 0.7
        user.email_verified = true
      else
        user.email_verified = false
      end
    else
      # Maneja el caso de error de la llamada a la API
      puts "Error al verificar el correo electrónico: #{response.status}"
    end

    user
  end
end