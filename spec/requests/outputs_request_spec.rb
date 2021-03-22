require 'rails_helper'

RSpec.describe "Outputs", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/outputs/index"
      expect(response).to have_http_status(:success)
    end
  end

end
