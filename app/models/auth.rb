class Auth
  ALGORITHM = 'HS256'

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    return nil if user.blank?
    return nil unless user.authenticate(password)

    self.authenticate_user(user)
  end

  def self.authenticate_user(user)
    auth_token = AuthToken.generate!(user)

    self.issue({
      token: auth_token.token
    })
  end

  def self.lookup_user(auth_header)
    auth_token_string = extract_token_from_auth_header(auth_header)
    AuthToken.find_user(auth_token_string)
  rescue JWT::DecodeError
    nil
  end

  def self.destroy_token(auth_header)
    auth_token_string = extract_token_from_auth_header(auth_header)
    AuthToken.where(token: auth_token_string).delete_all
  rescue JWT::DecodeError
    nil
  end

  private

  def self.issue(payload)
    JWT.encode(
      payload,
      secret_key,
      ALGORITHM
    )
  end

  def self.decode(token)
    JWT.decode(
      token,
      secret_key,
      true,
      {algorithm: ALGORITHM}
    ).first
  end

  def self.secret_key
    Rails.application.credentials.dig(:jwt_secret_key)
  end

  def self.extract_token_from_auth_header(auth_header)
    encoded_token = auth_header.split(' ').last
    decoded_token = decode(encoded_token)
    decoded_token["token"]
  end
end