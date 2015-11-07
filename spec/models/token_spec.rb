require "rails_helper"

describe Token do
  it "defines a client ID constant" do
    expect(Token::CLIENT_ID).to eq(ENV["DRIBBBLE_CLIENT_ID"])
  end

  it "defines a client scope constant" do
    expect(Token::CLIENT_SCOPE).to eq("public")
  end

  it "defines a client secret constant" do
    expect(Token::CLIENT_SECRET).to eq(ENV["DRIBBBLE_CLIENT_SECRET"])
  end

  it "defines a client options constant" do
    expect(Token::CLIENT_OPTIONS).to eq({
      site:          "https://api.dribbble.com",
      token_url:     "https://dribbble.com/oauth/token",
      authorize_url: "https://dribbble.com/oauth/authorize"
    })
  end
end

describe Token, "#authorize_url" do
  let(:id)      { Token::CLIENT_ID }
  let(:url)     { double(:url) }
  let(:code)    { double(:code) }
  let(:scope)   { Token::CLIENT_SCOPE }
  let(:client)  { double(:client) }
  let(:secret)  { Token::CLIENT_SECRET }
  let(:options) { Token::CLIENT_OPTIONS }

  before do
    allow(code).to receive(:authorize_url).and_return(url)
    allow(client).to receive(:auth_code).and_return(code)
    allow(OAuth2::Client).to receive(:new).and_return(client)
  end

  it "creates an OAuth client" do
    Token.authorize_url

    expect(OAuth2::Client).to have_received(:new).with(id, secret, options)
  end

  it "returns the authroize URL from the client" do
    expect(Token.authorize_url).to eq(url)
    expect(code).to have_received(:authorize_url).with(scope: scope)
  end
end
