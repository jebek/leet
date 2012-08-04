require 'rubygems'
require 'httparty'
class Quizlet 
  include HTTParty
  base_uri 'https://api.quizlet.com/2.0/sets/'
  
  def initialize(term, definition)
    self.name = term
    self.definition = definition
  end
  
  
  def self.find_in_quizlet(set_id, vset_id)
    client_id = '?client_id=8VbVfgpqrp&whitespace=1'
    response = get('https://api.quizlet.com/2.0/sets/' + set_id + '?client_id=8VbVfgpqrp&whitespace=1')
    if response.success?
      response['terms'].each do |r|
        Word.create!(:name => r["term"], :definition => r["definition"], :vset_id => vset_id)
      end
    else
      # this just raises the net/http response that was raised
      raise response.response    
    end
  end
end