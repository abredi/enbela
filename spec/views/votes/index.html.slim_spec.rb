require 'rails_helper'

RSpec.describe "votes/index", type: :view do
  before(:each) do
    assign(:votes, [
      Vote.create!(
        user: nil,
        article: nil
      ),
      Vote.create!(
        user: nil,
        article: nil
      )
    ])
  end

  it "renders a list of votes" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
