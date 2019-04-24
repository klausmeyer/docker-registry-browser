require "rails_helper"

describe "routes for repos" do
  it "routes GET /repo/foo.bar to the repositories controller" do
    expect(get("/repo/foo.bar")).to route_to(
      controller: "repositories",
      action:     "show",
      repo:       "foo.bar"
    )
  end
end

describe "routes redirect for repos", type: :request do
  it "routes GET /foo.bar to the tags controller" do
    expect(get("/foo.bar")).to redirect_to('/repo/foo.bar')
  end
end
