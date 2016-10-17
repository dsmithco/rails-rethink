require 'rails_helper'

RSpec.describe PartialsController, type: :controller do

  describe "GET #add" do
    it "returns http success" do
      get :add
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #reload" do
    it "returns http success" do
      get :reload
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #remove" do
    it "returns http success" do
      get :remove
      expect(response).to have_http_status(:success)
    end
  end

end
