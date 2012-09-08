class WordsController < ApplicationController
  def index
    @words = Word.all
  end
  
  def new
    @word = Word.new
    @vset = Vset.find(params[:vset_id])
  end
  
  def create
    @vset = Vset.find(params[:vset_id])
    @word = @vset.words.create!(params[:word])
    flash[:notice] = "#{@word.name} was succesfully created."
    redirect_to vset_path(@word.vset)
  end
  
  def edit
    @vset = Vset.find(params[:vset_id])
    @word = Word.find(params[:id])
  end
  
  def update
    @word = Word.find(params[:id])
    @word.update_attributes!(params[:word])
    flash[:notice] = "#{@word.name} was successfully updated."
    redirect_to vset_path(@word.vset)
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
  
end
