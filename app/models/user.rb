class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def self.guest
    find_or_create_by!(email: "aaa@aaa.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.last_name = "ゲスト"
      user.first_name = "ユーザー"
      user.last_name_kana = "ゲスト"
      user.first_name_kana = "ユーザー"
      user.user_name = "ゲスト"
    end
  end
  
  def self.check(traveller)
    where(["user_name like?","%#{traveller}%"])
  end
  
  def full_name
    self.last_name + self.first_name
  end
  
  has_one_attached :profile_image
  
  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/hito.jpg")
      profile_image.attach(io: File.open(file_path),filename: "default-image.jpg",content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  has_many :posts,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :comments,dependent: :destroy
  
  # フォローをした、されたの関係
  has_many :relationships,class_name: "Relationship",foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
  
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :follow
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  # フォローした時の処理
  def follow(user_id)
    relationships.create(follow_id: user_id)
  end
  
  # フォローを外す時の処理
  def unfollow(user_id)
    relationships.find_by(follow_id: user_id).destroy
  end
  
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
  
  enum privacy:{nonreleased: 0, released: 1}
  
  enum status:{"有効": false, "停止": true} 
  
end
