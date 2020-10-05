require 'rails_helper'

RSpec.feature 'Votes', type: :feature do
  login

  scenario 'redirect to create article page' do
    visit article_path(@category)
    click_on 'Vote'

    expect(page).to have_text('vote was successfully created.')
  end
end
