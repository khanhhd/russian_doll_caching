class Customer < ActiveRecord::Base
  has_many :products
end
