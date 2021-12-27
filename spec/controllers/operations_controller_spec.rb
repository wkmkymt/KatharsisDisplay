require 'rails_helper'

RSpec.describe OperationsController, type: :controller do

  describe "GET #ads_list" do
    it "returns http success" do
      get :ads_list
      expect(response).to have_http_status(:success)
    end
  end

end
