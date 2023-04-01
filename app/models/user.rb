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
  
  def full_name
    self.last_name + self.first_name
  end
  
  has_one_attached :profile_image
  
  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/hito.jpg")
      profile_image.attach(io: File.open(file_path),filename: "default-image.jpg",content_type: "image/jpeg,image/png")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  validate :profile_image_type
  
  has_many :posts,dependent: :destroy
  has_many :favorites,dependent: :destroy
  
  # フォローをした、されたの関係
  has_many :relationships,class_name: "Relationship",foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  private
  def profile_image_type
    if !profile_image.blob.content_type.in?(%("image/jpeg image/png"))
      errors.add(:profile_image, "はjpeg又はpng形式でアップロードしてください")
    end
  end
  
end
