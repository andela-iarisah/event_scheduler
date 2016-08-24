require 'rails_helper'

describe GroupEventsController, type: :controller do
  let(:user) { create(:user) }
  let(:incomplete_group_event) { create(:incomplete_group_event, user: user) }

  before { sign_in user }

  describe "GET #index" do
    it "populates an array of group events" do
      get :index
      expect(assigns(:group_events)).to eq([incomplete_group_event])
    end

    it "renders the index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #new" do
    it "has a new instance of group event" do
      new_group_event = build(:incomplete_group_event)
      expect(GroupEvent).to receive(:new) { new_group_event }

      get :new

      expect(assigns(:group_event)).to eq(new_group_event)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new group event" do
        expect{
          post :create, group_event: attributes_for(:complete_group_event)
        }.to change(GroupEvent, :count).by(1)
      end

      it "redirects to the new contact" do
        post :create, group_event: attributes_for(:complete_group_event)
        expect(response).to redirect_to(group_events_path)
      end
    end

    context "with invalid attributes" do
      it "does not save the new group event" do
        expect{
          post :create, group_event: attributes_for(:invalid_group_event)
        }.to_not change(GroupEvent, :count)
      end

      it "re-renders the new method" do
        post :create, group_event: attributes_for(:invalid_group_event)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "renders edit template" do
      get :edit, id: incomplete_group_event
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do

    context "valid attributes" do
      it "finds the group event" do
        put :update, id: incomplete_group_event, group_event: attributes_for(:incomplete_group_event)
        expect(assigns(:group_event)).to eq(incomplete_group_event)
      end

      it "changes the group event's attributes" do
        put :update, id: incomplete_group_event, group_event: attributes_for(:complete_group_event, name: "Jay")
        incomplete_group_event.reload
        expect(incomplete_group_event.name).to eq("Jay")
      end

      it "redirects to the updated contact" do
        put :update, id: incomplete_group_event, group_event: attributes_for(:complete_group_event)
        expect(response).to redirect_to(group_events_path)
      end
    end

    context "invalid attributes" do
      it "finds the group_event" do
        put :update, id: incomplete_group_event, group_event: attributes_for(:invalid_group_event)
        expect(assigns(:group_event)).to eq(incomplete_group_event)
      end

      it "does not update attributes" do
        put :update, id: incomplete_group_event, group_event: attributes_for(:invalid_group_event, name: "Mamamia")
        incomplete_group_event.reload
        expect(incomplete_group_event.name).not_to eq("Mamamia")
        expect(incomplete_group_event.name).to eq(incomplete_group_event.name)
      end

      it "re-renders the edit method" do
        put :update, id: incomplete_group_event, group_event: attributes_for(:invalid_group_event)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do

    it "deletes the group event" do
      delete :destroy, id: incomplete_group_event
      expect(GroupEvent.exists?(incomplete_group_event.id)).to be_falsey
    end

    it "redirects to #index" do
      delete :destroy, id: incomplete_group_event
      expect(response).to redirect_to(group_events_url)
    end
  end

  describe 'GET #deleted' do
    it "renders the correct template" do
      get :deleted
      expect(response).to render_template(:deleted)
    end
  end
end
