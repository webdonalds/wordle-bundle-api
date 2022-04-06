module UserAuthentications
  class Google < UserAuthentication
    def self.find_or_create_by_id_token!(id_token)
      validator = GoogleIDToken::Validator.new
      payload   = validator.check(id_token, client_id)
      find_or_create_by!(auth_id: payload["sub"]) do |auth|
        email = payload["email"]
        auth.create_user(display_name: email.split("@").first, email: email)
      end
    end

    def self.client_id
      @client_id ||= ENV["GOOGLE_CLIENT_ID"]
    end
  end
end
