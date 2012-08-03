class WordsController < ApplicationController
  def index
    @words = Word.all
  end
  
  def new
  end
  
  def create
    @word = Word.create!(params[:word])
    flash[:notice] = "#{@word.name} was succesfully created."
    redirect_to vset_words_path
  end
  
  def edit
    @word = Word.find(params[:id])
  end
  
  def update
    @word = Word.find(params[:id])
    @word.update_attributes!(params[:word])
    flash[:notice] = "#{@word.name} was successfully updated."
    redirect_to vset_word_path(@word)
  end
  
  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    flash[:notice] = "#{@word.name} was successfully deleted."
    redirect_to vset_path(@word.vset)
  end
  
  def show
    @word = Word.find(params[:id])
  end
  
  def search_quizlet
    @words = Word.find_in_quizlet(params[:search_terms])
  end
  
  def quiz
    @words = Word.find_all_by_vset_id(params[:vset_id]).shuffle
    @questions = @words.map { |a| a.name }
    @answers = @words.map { |a| a.definition }
    @answer_choices = @answers.map { |a| [a, "b", "c", "d"].shuffle }
  end
end
