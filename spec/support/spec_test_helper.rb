RSpec.configure do |config|
  config.before(type: :feature) do
    @user = User.create(name: 'recca')
    @category = Category.last.id
  end

  def login
    before do
      visit new_session_path
      fill_in 'user_name', with: @user.name
      click_on 'Sign In'
    end
  end
end

module SpecTestHelper
  def login_r(user)
    user = User.where(name: user.to_s).first if user.is_a?(Symbol)
    request.session[:user] = user.id
  end

  def current_user
    User.find(request.session[:user])
  end
end
