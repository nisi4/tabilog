class Post < ApplicationRecord
    
    has_one_attached :image
    belongs_to :user
    belongs_to :town
    belongs_to :category
end
