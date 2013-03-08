class User < ActiveRecord::Base
  include ApiToken

  has_many :beers
end
