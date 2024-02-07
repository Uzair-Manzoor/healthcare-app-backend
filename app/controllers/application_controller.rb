class ApplicationController < ActionController::API
  attr_reader :current_user

  before_action :authenticate_token!

  private

  def authenticate_token!
    header = request.headers['Authorization']
    header = header.split.last if header
    begin
      @payload = JsonWebToken.decode(header)
      @current_user = User.find(@payload['sub'])
    rescue JWT::ExpiredSignature
      render json: { error: 'your authentication token is expired' }
    rescue JWT::DecodeError
      render json: { error: 'Incorrect authentication token' }
    end
  end
end
