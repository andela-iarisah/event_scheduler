require 'rails_helper'

describe Api::V1::GroupEventsController do

  let(:group_event) { create(:complete_group_event) }

  describe "GET#index" do

    it "returns ok status" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "GET#show" do

    it "returns ok status when group event is available" do
      get :show, id: group_event.id
      expect(response.status).to eq(200)
    end

    it "returns 404 status when group event is not available" do
      get :show, id: 1000
      expect(response.status).to eq(404)
    end
  end

  describe "POST#create" do

    let(:new_group_event) { build(:incomplete_group_event) }

    it "returns ok status when group event is successfully created" do
      post :create, group_event: attributes_for(:incomplete_group_event)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['name']).to eq(new_group_event.name)
      expect(response.header['Content-Type']).to include('application/json')
      expect(response.status).to eq(200)
    end
  end

  describe "PUT#update" do

    it "returns ok status when group event is successfully updated" do
      put :update, group_event: attributes_for(:incomplete_group_event, name: "Jay"), id: group_event
      expect(response.status).to eq(200)
    end
  end

  describe "DELETE#destroy" do

    it "deletes record" do
      delete :destroy, id: group_event.id
      expect(GroupEvent.exists?(group_event.id)).to be false
      expect(response.status).to eq(204)
    end
  end

  describe "GET#deleted" do

    it "returns status 200" do
      get :deleted
      expect(response.status).to eq(200)
    end
  end
end
