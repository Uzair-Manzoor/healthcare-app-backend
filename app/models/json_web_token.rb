class JsonWebToken
  def self.encode(payload)
    expiration = 10.minutes.from_now.to_i
    JWT.encode(payload.merge(exp: expiration), ENV.fetch('DEVISE_JWT_SECRET_KEY', nil), 'HS256')
  end

  def self.decode(token)
    JWT.decode(token, ENV.fetch('DEVISE_JWT_SECRET_KEY', nil), true, algorithm: 'HS256').first
  end
end
