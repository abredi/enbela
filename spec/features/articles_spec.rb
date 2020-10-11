require 'rails_helper'

RSpec.feature 'Articles', type: :feature do
  login

  scenario 'redirect to create article page' do
    visit articles_path
    click_link(class: 'write_article')

    expect(current_path).to eql(new_article_path)
  end

  scenario 'logout and redirect to login page' do
    visit articles_path
    click_link 'Log out'

    expect(current_path).to eql(new_session_path)
  end
end
