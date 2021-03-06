class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # フォロー、フォロワー
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  has_many :user_rooms
  has_many :chats

  attachment :profile_image

  # def follow(other_user)
  #   following << other_user
  # end

  # def unfollow(other_user)
  #   active_relationships.find_by(followed_id).destroy
  # end

  def following?(other_user)
    following.include?(other_user)
  end

  #検索
  def self.looks(search, word)
    case search
      when "perfect_match"
        @user = User.where("name LIKE?", "#{word}")
      when "forward_match"
        @user = User.where("name LIKE?", "#{word}%")
      when
        @user = User.where("name LIKE?", "%#{word}")
      when "partial_match"
        @user = User.where("name LIKE?", "%#{word}%")
    end
  end

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

end
