require 'rails_helper'

RSpec.feature 'Votes', type: :feature do
  login

  scenario 'redirect to create article page' do
    visit article_path(@category)

    expect(page).to have_text('Voted')
  end
end
