class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

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




  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, length: {maximum: 20, minimum: 2}
  validates :introduction, length:{maximum: 50}


end


