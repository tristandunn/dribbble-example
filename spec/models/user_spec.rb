require "rails_helper"

describe User, "#initialize" do
  let(:token)  { Kernel.rand.to_s }
  let(:client) { double(:client) }

  before do
    allow(Token).to receive(:client).and_return(client)
    allow(OAuth2::AccessToken).to receive(:from_hash)
  end

  it "creates an access token" do
    User.new(token)

    expect(OAuth2::AccessToken).to have_received(:from_hash).with(client, access_token: token)
  end
end

describe User, "#attributes" do
  let(:user)       { User.new(double) }
  let(:token)      { double(:token) }
  let(:response)   { double(:response) }
  let(:attributes) { { "id" => 3290 } }

  before do
    allow(response).to receive(:parsed).and_return(attributes)
    allow(token).to receive(:get).and_return(response)
    allow(OAuth2::AccessToken).to receive(:from_hash).and_return(token)
  end

  it "retrieves the user" do
    user.attributes

    expect(token).to have_received(:get).with("/v1/user")
  end

  it "returns the user attributes" do
    expect(user.attributes).to eq(attributes)
  end
end
