class User < ActiveRecord::Base
  has_many :identities

  def self.create_with_omniauth(info)
    create(email: info['email'])
  end
end
