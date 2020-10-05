require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  scenario 'login' do
    visit new_session_path
    within('form') do
      fill_in 'user_name', with: @user.name
      click_on 'Sign In'
    end
    expect(page).to have_text('LOG OUT')
  end
end
