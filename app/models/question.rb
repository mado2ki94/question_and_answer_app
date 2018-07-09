class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :favorites, dependent: :destroy
  default_scope -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 10000 }
  validates :user_id, presence: true
  # 質問の解決or未解決判定用。デフォルトは0、解決後1
  validates :resolution, presence: true
end
