class Post < ApplicationRecord
    
    has_one_attached :image
    belongs_to :user
    belongs_to :town
    belongs_to :category
    has_many :favorites,dependent: :destroy
    has_many :comments,dependent: :destroy
    
    def self.search(keyword)
        joins(:town,:user).where(["title like? OR body like? OR town_name like? OR user_name like?","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%"])
    end
    
    def favorited_by?(user)
        favorites.exists?(user_id: user.id)
    end
    
    def self.sort(selection)
        case selection
        when "likes"
            return find(Favorite.group(:post_id).order(Arel.sql("count(user_id) desc")).pluck(:post_id))
        when "dislikes"
            return find(Favorite.group(:post_id).order(Arel.sql("count(user_id) asc")).pluck(:post_id))
        end
    end
end
