
class User < ActiveRecord::Base
  has_many :rates
  accepts_nested_attributes_for :rates

#  validates :name, :presence => true
#  validates :email, :presence => true

end


