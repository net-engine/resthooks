class User < ActiveRecord::Base
  include ApiToken

  has_many :beers
  has_many :burgers
end
