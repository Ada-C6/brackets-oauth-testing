class User < ActiveRecord::Base
  has_many :pages
  
  validates :uid, presence: true, uniqueness: { scope: :provider,
    message: "Cannot have multiple users from the same provider with the same UID"}
  validates :provider, presence: true
end
