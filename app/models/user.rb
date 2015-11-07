class User
  # Create an OAuth2::AccessToken from the provided access token and our client.
  def initialize(access_token)
    @token = OAuth2::AccessToken.from_hash(Token.client, access_token: access_token)
  end

  # Fetch the user's attributes as parsed JSON with indifferent access and
  # memoize.
  def attributes
    @attributes ||= @token.get("/v1/user").parsed.with_indifferent_access
  end
end
