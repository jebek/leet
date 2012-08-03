class Vset < ActiveRecord::Base
  
  attr_accessible :title, :description
  has_many :words, :dependent => :destroy
  
  
  
end
