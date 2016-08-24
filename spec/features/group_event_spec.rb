require 'rails_helper'

describe "Group Event", type: :feature do
  let(:first_user) { create(:user, email: 'jay@me.com') }
  let(:second_user) { create(:user, email: 'me@me.com') }

  scenario "user can create a group event" do
    user_creates_group_event
  end

  scenario "second user does not see first user's group event" do
    visit root_path
    login second_user
    expect(page).not_to have_content("Jay's Birthday")
  end

  scenario "user can edit group event" do
    user_creates_group_event
    click_on 'Edit'
    fill_in 'group_event_name', with: "The Offsite"
    click_on 'Save'
    expect(page).not_to have_content("Jay's Birthday")
    expect(page).to have_content('The Offsite')
  end

  scenario "user can delete group event" do
    user_creates_group_event
    click_on 'Delete'
    expect(page).not_to have_content("Jay's Birthday")
  end

  def user_creates_group_event
    given_user_logs_in
    when_user_fills_an_incomplete_group_event
    click_on 'Save'
    then_the_group_event_should_exist
  end

  def given_user_logs_in
    visit root_path
    login first_user
  end

  def when_user_fills_an_incomplete_group_event
    click_on 'Add a Group Event'
    fill_in 'group_event_name', with: "Jay's Birthday"
    select 'November', from: 'group_event_start_on_2i'
    select 'December', from: 'group_event_end_on_2i'
  end

  def then_the_group_event_should_exist
    expect(page).to have_content('Add a Group Event')
    expect(page).to have_content('Edit')
    expect(page).to have_content('Status')
  end
end
