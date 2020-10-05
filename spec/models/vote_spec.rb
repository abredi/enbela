require 'rails_helper'

RSpec.describe Vote, type: :model do
  context 'Associations' do
    it { expect(subject).to belong_to :user }
    it { expect(subject).to belong_to :article }
  end
end
