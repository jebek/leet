class ResultsController < ApplicationController
  def create
    params['_json'].each do |word|
      
    @result = current_user.results.find_or_create_by_word_id(:word_id => word["word_id"])
    @result.num_of_correct(word["correct"])
    @result.save
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
end
