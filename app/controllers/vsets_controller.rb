class VsetsController < ApplicationController
  def index
    @Vsets = Vset.all
  end
  
  def new
  end
  
  def create
    @Vset = Vset.create!(params[:Vset])
    flash[:notice] = "#{@Vset.title} was succesfully created."
    redirect_to Vsets_path
  end
  
  def edit
    @Vset = Vset.find(params[:id])
  end
  
  def update
    @Vset = Vset.find(params[:id])
    @Vset.update_attributes!(params[:Vset])
    flash[:notice] = "#{@Vset.title} was successfully updated."
    redirect_to Vset_path(@Vset)
  end
  
  def destroy
    @Vset = Vset.find(params[:id])
    @Vset.destroy
    flash[:notice] = "#{@Vset.title} was successfully deleted."
    redirect_to Vsets_path
  end
  
  def show
    @Vset = Vset.find(params[:id])
  end
  
  def search_quizlet
    @Vsets = Vset.find_in_quizlet(params[:search_terms])
 
  end
  
  def quiz
    @Vsets = Vset.all.shuffle
    #@questions = @Vsets.map { |a| a.title }
    #@answers = @Vsets.map { |a| a.rating }
    #@answer_choices = @answers.map { |a| [a, "b", "c", "d"].shuffle }
  end
end
