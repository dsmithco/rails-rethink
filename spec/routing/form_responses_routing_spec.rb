require "rails_helper"

RSpec.describe FormResponsesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/form_responses").to route_to("form_responses#index")
    end

    it "routes to #new" do
      expect(:get => "/form_responses/new").to route_to("form_responses#new")
    end

    it "routes to #show" do
      expect(:get => "/form_responses/1").to route_to("form_responses#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/form_responses/1/edit").to route_to("form_responses#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/form_responses").to route_to("form_responses#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/form_responses/1").to route_to("form_responses#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/form_responses/1").to route_to("form_responses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/form_responses/1").to route_to("form_responses#destroy", :id => "1")
    end

  end
end
