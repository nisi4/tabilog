class Post < ApplicationRecord
    
    has_one_attached :image
    belongs_to :user
    belongs_to :town
    belongs_to :category
    
    def self.search(keyword)
        where(["title like? OR body like?","%#{keyword}%", "%#{keyword}%"])
    end
    
    def self.search(name)
        Post.joins(:town,:user).where(["town_name like? OR user_name like?","%#{name}%", "%#{name}%"])
    end
end
