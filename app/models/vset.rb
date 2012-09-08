class Vset < ActiveRecord::Base
  
  attr_accessible :title, :description, :tag_list
  has_many :words, :dependent => :destroy
  
  acts_as_taggable_on :tags
  
  
  
end
