class User < ActiveRecord::Base
  has_many :pages

  validates :uid, presence: true, uniqueness: { scope: :provider,
    message: "Cannot have multiple users from the same provider with the same UID"}
    validates :provider, presence: true

    def self.build_from_github(auth_hash)
      user       = User.new
      user.uid   = auth_hash[:uid]
      user.provider = 'github'
      user.name  = auth_hash['info']['name']
      user.email = auth_hash['info']['email']

      return user
    end
  end
