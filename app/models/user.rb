class User < ActiveRecord::Base
    validates :email,  presence: true,  uniqueness: true
    validates :password,  presence: true
    
    has_secure_password
    # AR method "authenticate" checks against bcrypt to check password - see UserTable migration

    has_many :blog_posts
end 