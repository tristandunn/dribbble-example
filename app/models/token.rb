class Token
  # Settings for the OAuth client.
  CLIENT_ID      = ENV["DRIBBBLE_CLIENT_ID"].freeze
  CLIENT_SCOPE   = "public".freeze
  CLIENT_SECRET  = ENV["DRIBBBLE_CLIENT_SECRET"].freeze
  CLIENT_OPTIONS = {
    site:          "https://api.dribbble.com".freeze,
    token_url:     "https://dribbble.com/oauth/token".freeze,
    authorize_url: "https://dribbble.com/oauth/authorize".freeze
  }.freeze

  # Create an OAuth client with our settings.
  def self.client
    OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, CLIENT_OPTIONS)
  end

  # Create a token with our client using the code provided.
  def self.create_from_code(code)
    client.auth_code.get_token(code).token
  end

  # Generate an authorization URL with our client.
  def self.authorize_url
    client.auth_code.authorize_url(scope: CLIENT_SCOPE)
  end
end
