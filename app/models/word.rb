class Word < ActiveRecord::Base
  attr_accessible :name, :definition, :vset_id
  belongs_to :vset
  has_many :results, :dependent => "destroy"
  has_many :users, :through => :results
  
 
end
