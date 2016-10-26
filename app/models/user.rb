class User < ApplicationRecord

  has_many :addresses
  has_many :items
end
