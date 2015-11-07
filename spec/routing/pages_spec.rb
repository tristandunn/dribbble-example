require "rails_helper"

describe PagesController do
  it { expect(get: "/").to route_to(controller: "pages", action: "index") }
end
