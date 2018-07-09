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

  # like数の上位10を抽出
  def self.ranking
    self.order('liker DESC').limit(10)
  end

  # 検索機能
  def self.search(search)
    search ? self.where(['title LIKE ?', "%#{search}%"]) : self.all
  end

end
