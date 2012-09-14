class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  
  #validates :user_id, presence: true
  #validates :word_id, presence: true
  
  def num_of_correct(crct)
    if self.total.nil?
      self.total = 1
    else
      self.total += 1
    end
    
    if crct == 1
      if self.correct.nil?
        self.correct = 1
      else
        self.correct += 1
      end 
    else
      self.correct = 0
    end
  end
end
