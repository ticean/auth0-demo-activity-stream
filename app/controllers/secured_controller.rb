class SecuredController < ApplicationController
  before_action :validate_token

  class InvalidTokenError < StandardError; end

  private

  def requires_role(decoded_token, role)
    #raise InvalidTokenError unless
  end

  def validate_token
    begin
      authorization = request.headers['Authorization']
      raise InvalidTokenError if authorization.nil?

      token = request.headers['Authorization'].split(' ').last
      decoded_token = JWT.decode(token,
        JWT.base64url_decode(Rails.application.secrets.auth0_client_secret))
      Rails.logger.info("Decoded JWT token: #{decoded_token}")

      # For now we will allow valid tokens for ANY audience, but we'll check
      # that the user has the admin rol. This should be further restricted.
      #raise InvalidTokenError if Rails.application.secrets.auth0_client_id != decoded_token[0]["aud"]
    rescue JWT::DecodeError, InvalidTokenError
      render text: "Unauthorized", status: :unauthorized
    end
  end
end
