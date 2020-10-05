# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  subject do
    Article.last
  end

  let(:user) { subject.user }
  let(:category) { subject.category }

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
    it { expect(Article.categories).to be_instance_of(Array) }
    it { expect(Article.categories[0].category).to be_instance_of(Category) }
    it { expect(Article.categories[0].category.id).to eq(category.id) }
    it { expect(Article.categories[0].category.name).to eq(category.name) }
    it { expect(Article.articles(subject.category.id)).to be_instance_of(Array) }
    it { expect(Article.articles(subject.category.id)[0].user).to be_instance_of(User) }
    it { expect(Article.articles(subject.category.id)[0].title).to eq(subject.title) }
    it { expect(Article.featured.length).to eq(1) }
  end
end
