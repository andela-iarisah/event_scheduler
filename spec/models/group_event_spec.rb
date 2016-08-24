require 'rails_helper'

describe GroupEvent do
  context "associations" do
    it {is_expected.to belong_to :user}
  end

  describe "does not save with invalid dates" do
    it do
      expect{
        create(:invalid_group_event)
      }.to raise_error("Validation failed: End on must be after state date")
    end
  end

  describe "saves with correct attributes" do
    it do
      expect{
        create(:complete_group_event)
      }.not_to raise_error
    end
  end

  context "scopes" do
    let(:new_group_event) { create(:incomplete_group_event) }
    let(:soft_deleted_group_event) { create(:complete_group_event, deleted_at: Time.now) }

    describe "deleted_group_events" do
      it do
        expect(GroupEvent.deleted_group_events).to eq([soft_deleted_group_event])
      end
    end
  end
end
