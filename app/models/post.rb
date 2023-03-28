class Post < ApplicationRecord
    
    has_one_attached :image
    belongs_to :user
    belongs_to :town
    belongs_to :category
    
    def self.search(keyword)
        joins(:town,:user).where(["title like? OR body like? OR town_name like? OR user_name like?","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%"])
    end
end
