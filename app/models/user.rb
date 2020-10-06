class User < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { within: 3..20 }

  has_many :articles, dependent: :destroy
  has_many :votes, dependent: :destroy
end
