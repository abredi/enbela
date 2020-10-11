require 'rails_helper'

RSpec.describe Article, type: :model do
  subject do
    Article.first
  end

  let(:user) { subject.user }
  let(:user1) { User.create!(name: 'recca') }

  let(:category) { subject.category }
  let(:top_category) { Category.order('priority desc').limit(1) }

  context 'Validations' do
    it { expect(subject).to validate_presence_of(:title) }
    it { expect(subject).to validate_presence_of(:text) }

    it 'is expected to validate that :title cannot be empty/falsy' do
      subject.title = nil
      subject.valid?
      expect(subject.errors[:title]).to_not include('Title can\'t be blank')
    end
  end

  context 'Associations' do
    it { expect(subject).to belong_to :user }
    it { expect(subject).to belong_to :category }
    it { expect(subject).to have_many :votes }
  end

  context 'Scope' do
    it { expect(Article.cat_list).to be_instance_of(Array) }
    it { expect(Article.cat_list.first.category).to be_instance_of(Category) }
    it { expect(Article.cat_list.first.category_id).to eq(top_category[0].id) }
    it { expect(Article.cat_list.first.name).to eq(top_category[0].name) }
    it { expect(Article.articles(subject.category.id, user1.id)).to be_instance_of(Array) }
    it { expect(Article.articles(subject.category.id, user1.id)[0].user).to be_instance_of(User) }
    it { expect(Article.articles(subject.category.id, user1.id)[0].title).to eq(subject.title) }
    it { expect(Article.featured.length).to eq(1) }
  end
end
