class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  validates :nickname, presence: true, message: "ニックネームを入力してください"
  validates :password, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?[0-9])/, message: "パスワードは半角英字と数字の両方を含む形式で入力してください" }
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "名前は漢字、ひらがな、カタカナで入力してください" } do
    validates :fname
    validates :lname
  end
  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "名前(カナ)はカタカナで入力してください" } do
    validates :fname_kana
    validates :lname_kana
  end
  validates :birthdate, presence: true, message: "生年月日を入力してください"
end
