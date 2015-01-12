class Product < ActiveRecord::Base
  validates :name, :description, :price, presence: true
  belongs_to :category
end
