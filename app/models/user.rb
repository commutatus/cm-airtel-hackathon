class User < ApplicationRecord
  include CmAdmin::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: {
    user: 0,
    admin: 1,
    super_admin: 2
  }

  has_many :chatbots, dependent: :destroy
  has_many :intents, dependent: :destroy

  def password_required?
    return false
  end
end
