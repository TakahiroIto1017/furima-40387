class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  validates :password, format: { with: /\A(?=.*[a-z])(?=.*\d)[a-z\d]+\z/i }

  validates :nickname, presence: true
  validates :first_name, presence: true, format: { with: /\A[\p{Han}\p{Hiragana}\p{Katakana}]+\z/ }
  validates :last_name, presence: true, format: { with: /\A[\p{Han}\p{Hiragana}\p{Katakana}]+\z/ }
  validates :first_name_guide, presence: true, format: { with: /\A\p{Katakana}+\z/ }
  validates :last_name_guide, presence: true, format: { with: /\A\p{Katakana}+\z/ }
  validates :birthday, presence: true
end
