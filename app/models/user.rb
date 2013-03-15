class User < ActiveRecord::Base
  include ApiToken

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :beers
  has_many :burgers
  has_many :resource_subscriptions
end
