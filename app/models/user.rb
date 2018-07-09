class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likings, through: :likes, source: :answer
  validates :name, presence: true
  attr_accessor :confirmed_at
  mount_uploader :avatar, AvatarUploader

  # 開発環境でメール認証を避ける（本番環境ではコメントアウトする）
  def active_for_authentication?
    true
  end

  def like(answer)
    self.likes.find_or_create_by(answer_id: answer.id)
    answer.user.liker += 1
  end

  def unlike(answer)
    like = self.likes.find_by(answer_id: answer.id)
    like.destroy if like
    self.liker -= 1
  end

  def like?(answer)
    self.likings.include?(answer)
  end

  # like数の上位10人を抽出
  def self.ranking
    self.order('liker DESC').limit(10)
  end

  # ツイッターログイン用の設定
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        image: auth.info.image,
        name: auth.info.name,
        nickname: auth.info.nickname,
        location: auth.info.location
      )
    end

    user
  end

  private

    # ツイッターログイン用の設定
    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
end
