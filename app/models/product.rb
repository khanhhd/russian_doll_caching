class Product < ActiveRecord::Base
  belongs_to :customer, touch: true
end
