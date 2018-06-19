class Response < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :answer

  validates :content, presence: true, length: { maximum: 10000 }
  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :answer_id, presence: true
end
