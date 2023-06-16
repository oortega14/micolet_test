class UserService
  def self.verify_email(user)
    email = user.email
    api_key = 'TU_CLAVE_DE_API'
    url = "https://emailvalidation.abstractapi.com/v1/?api_key=#{api_key}&email=#{email}"

    response = HTTParty.get(url)

    if response.code == 200
      result = JSON.parse(response.body)
      if result['deliverability'] == 'DELIVERABLE'
        # El correo electrónico es válido y entregable
        user.email_verified = true
      else
        # El correo electrónico no es válido o no es entregable
        user.email_verified = false
      end
    else
      # Error en la solicitud a la API
      user.email_verified = false
    end

    user.save
  end
end