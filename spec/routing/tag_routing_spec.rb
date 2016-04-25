require "rails_helper"

describe "routes for tags" do
  it "routes GET /repo/foo.bar/tag/latest to the tags controller" do
    expect(get("/repo/foo.bar/tag/latest")).to route_to(
      controller: "tags",
      action:     "show",
      repo:       "foo.bar",
      tag:        "latest"
    )
  end

  it "routes GET /repo/foo/bar/tag/1.2.3 to the tags controller" do
    expect(get("/repo/foo/bar/tag/1.2.3")).to route_to(
      controller: "tags",
      action:     "show",
      repo:       "foo/bar",
      tag:        "1.2.3"
    )
  end
end
