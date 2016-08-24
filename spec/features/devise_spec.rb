require 'rails_helper'

describe "Devise", type: :feature do
  context "user" do
    scenario "user log in page" do
      visit new_user_session_path
      expect(page).to have_content('Log in')
    end

    scenario "user can sign up successfully" do
      user_sign_up
      expect(page).to have_content("Add a Group Event")
    end

    scenario "user can log in successfully" do
      visit root_path
      user_sign_up
      click_on 'Log Out'
      fill_user_details
      expect(page).to have_content("Add a Group Event")
    end

    scenario "user can log out successfully" do
      visit root_path
      user_sign_up
      click_on 'Log Out'
      expect(page).to have_content('Log in')
      expect(page).to have_content('Remember me')
    end
  end

  def user_sign_up
    visit root_path
    click_on 'Sign up'
    fill_in_sign_up_details
  end

  def fill_in_sign_up_details
    fill_in 'user_email', with: 'x@y.com'
    fill_in 'user_password', with: 'xicomske'
    fill_in 'user_password_confirmation', with: 'xicomske'
    click_on 'Sign up'
  end

  def fill_user_details
    fill_in 'user_email', with: 'x@y.com'
    fill_in 'user_password', with: 'xicomske'
    click_on 'Log in'
  end
end
