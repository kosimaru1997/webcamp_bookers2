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
  # フォロー
  has_many :active_rerationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :following, through: :active_rerationships, source: :followed
  # フォロワー
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships  #source: :follower

  attachment :profile_image
  
  def follow(other_user)
    following << other_user
  end
  
  def unfollow(other_user)
    active_rerationships.find_by(followed_id).destroy
  end
  
  def following?(other_user)
    following.include?(other_user)
  end

end
