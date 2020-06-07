class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # フォロー、フォロワー機能用
  has_many :follower, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :followed, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :follows, through: :follower, source: :followed # 自分がフォローしている人
  has_many :followers, through: :followed, source: :follower # 自分をフォローしている人
  #chat
  has_many :user_rooms
  has_many :rooms, through: :user_rooms
  # resources :rooms, only: [:show, :create]
  has_many :chats

 # ユーザーをフォローする
def follow(user_id)
  follower.create(followed_id: user_id)
end

# ユーザーのフォローを外す
def unfollow(user_id)
  follower.find_by(followed_id: user_id).destroy
end

# フォローしていればtrueを返す
def following?(user)
  follows.include?(user)
end


 #検索機能
    def self.search(search, user_or_book, how_search)
      if user_or_book == "user"
          if how_search == "1"
                    User.where(['name LIKE ?', "#{search}"])
            elsif how_search == "2"
                    User.where(['name LIKE ?', "#{search}%"])
            elsif how_search == "3"
                    User.where(['name LIKE ?', "%#{search}"])
            elsif how_search == "4"
                    User.where(['name LIKE ?', "%#{search}%"])
          else
              User.none
          end
      end
    end

# 住所自動入力
  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

# 住所自動入力ここまで

# 住所Map
  # geocoded_by :address
  # after_validation :address
  # after_validation :geocode #, if: :address_changed?

  # def address
  #   address = "#{self.prefecture_name}#{self.address_city}#{self.address_street}#{self.address_building}"     
  # end

# 住所Mapここまで
  attachment :profile_image, destroy: false


  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, length: {maximum: 20, minimum: 2}
  validates :introduction, length:{maximum: 50}


end


