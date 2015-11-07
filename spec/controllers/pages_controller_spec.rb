require "rails_helper"

describe PagesController, "#index" do
  before do
    get :index
  end

  it { should render_template(:index) }
end
