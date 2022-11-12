class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: {
    user: 0,
    admin: 1,
    super_admin: 2
  }
  # Remove this once role is setup and mentioned in zcm_admin.rb
  # def super_admin?
  #   true
  # end
end
