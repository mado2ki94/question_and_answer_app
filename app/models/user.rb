class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  has_many :questions, dependent: :destroy
  has_many :answers
  has_many :responses
  validates :name, presence: true
  attr_accessor :confirmed_at
  mount_uploader :avatar, AvatarUploader

  # 開発環境でメール認証を避ける（本番環境ではコメントアウトする）
  def active_for_authentication?
  true
  end
end
