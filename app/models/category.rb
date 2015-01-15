class Category < ActiveRecord::Base
  #validates :name, presence: true
  has_many :products, :dependent => :destroy
  accepts_nested_attributes_for :products, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

end
