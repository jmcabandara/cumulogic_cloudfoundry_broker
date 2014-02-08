require_relative "../../../story_helper.rb"

describe "CumulogicCloudfoundryBroker::v2::UsersStory" do

  describe "GET /users" do
    before do
      authorize 'admin', 'admin'
      get "/cumulogic_cloudfoundry_bridge/v2/users"
    end
    let(:resp) { json_parse(last_response.body) }
    let(:users) { resp[:users] }

    it "responds successfully" do
      last_response.status.must_equal 200
      resp[:status].must_equal "success"
    end

    it "returns 3 users" do
      users.size.must_equal 3
    end
  end

  describe "POST /users" do
    before do
      authorize 'admin', 'admin'
      post_json("/cumulogic_cloudfoundry_bridge/v2/users", {
        user: {
          name: "bob",
          email: "bob@test.com"
        }
      })
    end

    let(:resp) { json_parse(last_response.body) }

    it { resp[:status].must_equal "success" }
    it { resp[:user][:name].must_equal "bob" }
    it { resp[:user][:email].must_equal "bob@test.com" }
  end
end
