class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def self.guest
    find_or_create_by!(email: "aaa@aaa.com") do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
  
  def full_name
    self.last_name + self.first_name
  end
  
  has_many :posts,dependent: :destroy
  
end
