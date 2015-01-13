class Category < ActiveRecord::Base
  validates :name, presence: true
  has_many :products, :dependent => :destroy
  accepts_nested_attributes_for :products
end
