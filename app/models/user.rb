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

  has_many :chatbots
  has_many :intents

  def super_admin
    super_admin?
  end

  def password_required?
    return false
    super
  end
end
