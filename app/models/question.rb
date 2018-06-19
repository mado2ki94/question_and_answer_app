class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :responses
  default_scope -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 10000 }
  validates :user_id, presence: true
  validates :resolution, presence: true
end
