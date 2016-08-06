require "rails_helper"

describe SessionsController, "#new" do
  let(:code)  { Kernel.rand.to_s }
  let(:token) { Kernel.rand.to_s }

  before do
    allow(Token).to receive(:create_from_code).and_return(token)

    get :new, params: { code: code }
  end

  it "creates a token from the code parameter" do
    expect(Token).to have_received(:create_from_code).with(code)
  end

  it "assigns the token to the session" do
    expect(session[:token]).to eq(token)
  end

  it { should redirect_to(root_url) }
end

