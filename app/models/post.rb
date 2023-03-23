class Post < ApplicationRecord
    
    has_one_attached :image
    belongs_to :user
    belongs_to :town
    belongs_to :category
    
    def self.search(keyword)
        where(["title like? OR body like?","%#{keyword}%", "%#{keyword}%"])
    end
end
