class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname, presence: true
  validates :password, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?[0-9])/ }
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ } do
    validates :fname
    validates :lname
  end
  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/ } do
    validates :fname_kana
    validates :lname_kana
  end
  validates :birthdate, presence: true
end
