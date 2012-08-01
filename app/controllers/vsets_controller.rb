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
    @vset.update_attributes!(params[:Vset])
    flash[:notice] = "#{@vset.title} was successfully updated."
    redirect_to vset_path(@vset)
  end
  
  def destroy
    @vset = Vset.find(params[:id])
    @vset.destroy
    flash[:notice] = "#{@vset.title} was successfully deleted."
    redirect_to vsets_path
  end
  
  def show
    @vset = Vset.find(params[:id])
  end
  
  def search_quizlet
    @vsets = Vset.find_in_quizlet(params[:search_terms])
 
  end
  
  def quiz
    @vsets = Vset.all.shuffle
    #@questions = @Vsets.map { |a| a.title }
    #@answers = @Vsets.map { |a| a.rating }
    #@answer_choices = @answers.map { |a| [a, "b", "c", "d"].shuffle }
  end
end
