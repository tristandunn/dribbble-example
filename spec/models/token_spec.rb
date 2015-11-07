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
  let(:url)    { double(:url) }
  let(:code)   { double(:code) }
  let(:scope)  { Token::CLIENT_SCOPE }
  let(:client) { double(:client) }

  before do
    allow(code).to receive(:authorize_url).and_return(url)
    allow(client).to receive(:auth_code).and_return(code)
    allow(Token).to receive(:client).and_return(client)
  end

  it "returns the authroize URL from the client" do
    expect(Token.authorize_url).to eq(url)
    expect(code).to have_received(:authorize_url).with(scope: scope)
  end
end

describe Token, "#client" do
  let(:id)      { Token::CLIENT_ID }
  let(:url)     { double(:url) }
  let(:code)    { double(:code) }
  let(:client)  { double(:client) }
  let(:secret)  { Token::CLIENT_SECRET }
  let(:options) { Token::CLIENT_OPTIONS }

  before do
    allow(OAuth2::Client).to receive(:new).and_return(client)
  end

  it "creates an OAuth client" do
    Token.client

    expect(OAuth2::Client).to have_received(:new).with(id, secret, options)
  end

  it "returns the client" do
    expect(Token.client).to eq(client)
  end
end

describe Token, "#create_from_code" do
  let(:code)         { double(:code) }
  let(:token)        { double(:token) }
  let(:client)       { double(:client) }
  let(:remote_code)  { Kernel.rand.to_s }
  let(:remote_token) { Kernel.rand.to_s }

  before do
    allow(token).to receive(:token).and_return(remote_token)
    allow(code).to receive(:get_token).and_return(token)
    allow(client).to receive(:auth_code).and_return(code)
    allow(Token).to receive(:client).and_return(client)
  end

  it "creates a token with the provided code" do
    Token.create_from_code(remote_code)

    expect(code).to have_received(:get_token).with(remote_code)
  end

  it "returns the token" do
    expect(Token.create_from_code(remote_code)).to eq(remote_token)
  end
end
