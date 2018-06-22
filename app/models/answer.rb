class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :responses, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes, source: :user

  validates :content, presence: true, length: { maximum: 10000 }
  validates :user_id, presence: true
  validates :question_id, presence: true
end
