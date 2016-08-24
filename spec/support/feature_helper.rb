module FeatureHelper

  def login(a)
    fill_in 'user_email', with: a.email
    fill_in 'user_password', with: a.password
    click_button 'Log in'
  end
end
