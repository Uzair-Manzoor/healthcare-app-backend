class JsonWebToken
  def self.encode(payload)
    expiration = 30.minutes.from_now.to_i
    JWT.encode(payload.merge(exp: expiration), ENV.fetch('DEVISE_JWT_SECRET_KEY', DEFAULT_SECRET_KEY), 'HS256')
  end

  def self.decode(token)
    JWT.decode(token, ENV.fetch('DEVISE_JWT_SECRET_KEY', nil), true, algorithm: 'HS256').first
  end
end
