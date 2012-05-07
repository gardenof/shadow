require 'spec_helper'

describe CommlinksController do

  let (:commlink) { Factory :commlink }

  describe "index" do
    it "responds to json" do
      commlink
      get :index, format: 'json'
      response.should be_success
      response.body.should include commlink.to_json
    end
  end

  describe "show" do
    it "responds to json" do
      get :show, id: commlink.to_param, format: 'json'
      response.should be_success
      response.body.should == commlink.to_json
    end
  end

  describe "update" do
    it "accepts json" do
      new_name = "AAPL iCOMM"

      put :update, id: commlink.to_param, format: 'json',
        commlink: {
          model_name: new_name
        }

      commlink.reload
      commlink.model_name.should == new_name
    end
  end

  describe "create" do
    it "accepts json" do
      new_name = "AAPL iCOMM"

      post :create, format: 'json',
        commlink: {
          model_name: new_name
        }

      Commlink.last.model_name.should == new_name
    end
  end

end