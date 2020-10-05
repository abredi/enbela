require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_2) { User.create(name: 'Rebecca Y') }
  subject { User.create(name: 'Abd A') }

  before do
    Vote.create(user_id: subject.id, article_id: user_2.id)
  end

  context 'Validations' do
    it { expect(subject).to validate_presence_of(:name) }

    it { expect(subject).to validate_length_of(:name).is_at_most(20) }
  end

  context 'Associations' do
    it { expect(subject).to have_many(:articles) }
    it { expect(subject).to have_many(:votes) }
  end
end
