class Word < ActiveRecord::Base
  attr_accessible :name, :definition, :vset_id
  belongs_to :vset
  
 
end
