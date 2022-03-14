require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection

class User < ActiveRecord::Base
    has_secure_password
    has_many :posts
    has_many :favorites
    has_many :favorited_posts, through: :favorites, source: :post, dependent: :destroy
end

class Post < ActiveRecord::Base
    belongs_to :user
    has_many :favorites
    has_many :favorited_users, through: :favorites, source: :user, dependent: :destroy
end
    
class Favorite < ActiveRecord::Base
   belongs_to :user
   belongs_to :post
end