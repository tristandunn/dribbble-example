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

  # Generate an authorization URL with our client settings.
  def self.authorize_url
    client = OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, CLIENT_OPTIONS)
    client.auth_code.authorize_url(scope: CLIENT_SCOPE)
  end
end
