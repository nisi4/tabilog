class Post < ApplicationRecord
    attr_accessor :town_name
    
    has_one_attached :image
    belongs_to :user,optional: true
    belongs_to :town,optional: true
    belongs_to :category,optional: true
    has_many :favorites,dependent: :destroy
    has_many :comments,dependent: :destroy
    
    validates :image,presence: true
    validates :town,presence: true
    validates :category,presence: true
    validates :title,presence: true
    validates :star,presence: true
    
    def self.search(keyword)
        joins(:town,:user).where(["title like? OR body like? OR town_name like? OR user_name like?","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%"])
    end
    
    def favorited_by?(user)
        favorites.exists?(user_id: user.id)
    end
    
    def self.post_sort(selection)
        case selection
        when "likes"
            return left_outer_joins(:favorites).group('posts.id').select("`posts`.*", "COUNT(`favorites`.id) AS favo_count").order(favo_count: :desc)
        when "dislikes"
            return left_outer_joins(:favorites).group('posts.id').select("`posts`.*", "COUNT(`favorites`.id) AS favo_count").order(favo_count: :asc)
        end
    end
end
