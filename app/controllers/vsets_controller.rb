class VsetsController < ApplicationController
  def index
    @vsets = Vset.all
  end
  
  def new
  end
  
  def create
    @vset = Vset.create!(params[:Vset])
    flash[:notice] = "#{@vset.title} was succesfully created."
    redirect_to Vsets_path
  end
  
  def edit
    @vset = Vset.find(params[:id])
  end
  
  def update
    @vset = Vset.find(params[:id])
    @vset.update_attributes!(params[:vset])
    flash[:notice] = "#{@vset.title} was successfully updated."
    redirect_to vsets_path
  end
  
  def destroy
    @vset = Vset.find(params[:id])
    @vset.destroy
    flash[:notice] = "#{@vset.title} was successfully deleted."
    redirect_to vsets_path
  end
  
  def show
    @vset = Vset.find(params[:id])
    @words = @vset.words
  end
  
  def search_quizlet
    @words = Quizlet.find_in_quizlet(params[:search_terms], 2)
    redirect_to vsets_path
  end
  
  def quiz
    @words = Word.find_all_by_vset_id(params[:vset]).shuffle
    @questions = @words.map { |a| a.name }
    @answers = @words.map { |a| a.definition }
    
    @answer_choices = @answers.map { |a| @answers.reject { |answer| answer == a }.shuffle[0..2].push(a).shuffle }
  end
end
