class Town < ApplicationRecord
    
    has_many :posts,dependent: :destroy
    
    geocoded_by :town_name
    after_validation :geocode
end
