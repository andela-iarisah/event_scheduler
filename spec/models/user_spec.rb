require 'rails_helper'

describe User do
  context "associations" do
    it {is_expected.to have_many :group_events}
  end

  describe "valid user" do
    it "has a password" do
      user = create(:user, password: 'password')
      expect(user.password).to eq("password")
    end
  end
end
