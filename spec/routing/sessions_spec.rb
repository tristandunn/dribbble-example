require "rails_helper"

describe PagesController do
  it { expect(get: "/sessions/new").to route_to(controller: "sessions", action: "new") }
end
