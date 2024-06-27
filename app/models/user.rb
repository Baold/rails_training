class User < ApplicationRecord
    has_secure_password
    has_many :user_tokens
    has_many :jobs
    validates :email, presence: true , uniqueness: true
    validates :password, presence: true
end
