class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :content, presence: true, length: { maximum: 10000 }
  validates :user_id, presence: true
  validates :question_id, presence: true
end