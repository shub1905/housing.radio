class User < ActiveRecord::Base
  has_many :songs_queues
  has_many :user_queues
  before_create :admin_status

  def admin_status
    admin_users_email = ['saurabhgoel93@gmail.com','gg.gg1947@ymail.com','naman.gemini@gmail.com']
    self.roles = 1 if admin_users_email.include?(self.email)
  end

  def self.omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.image = auth.info.image
      user.token = auth.credentials.token
      user.expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end