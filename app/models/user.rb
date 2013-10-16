class User < OmniAuth::Identity::Models::ActiveRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :password, confirmation: true
  validates :password, length: { minimum: 6 }

  def self.find_with_omniauth(auth)
    find_by(email: auth['info']['email'])
  end
end
