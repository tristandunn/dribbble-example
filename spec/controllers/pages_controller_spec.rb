require "rails_helper"

describe PagesController, "#index" do
  before do
    get :index
  end

  it "does not assign a user" do
    expect(assigns(:user)).to be_nil
  end

  it { should render_template(:index) }
end

describe PagesController, "#index, when authenticated" do
  let(:user)  { double(:user) }
  let(:token) { Kernel.rand.to_s }

  before do
    allow(User).to receive(:new).with(token).and_return(user)

    session[:token] = token

    get :index
  end

  it "assigns the user" do
    expect(assigns(:user)).to eq(user)
  end

  it { should render_template(:index) }
end
