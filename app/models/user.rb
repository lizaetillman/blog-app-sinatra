class User < ActiveRecord::Base
    has_secure_password
    # AR method "authenticate" checks against bcrypt to check password - see UserTable migration

    has_many :blog_posts
end 