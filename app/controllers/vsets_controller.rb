class VsetsController < ApplicationController
  def index
    @vsets = Vset.all
  end
  
  def new
    @vset = Vset.new
  end
  
  def create
    @vset = Vset.create!(params[:vset])
    flash[:notice] = "#{@vset.title} was succesfully created."
    redirect_to @vset
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
    @vset = Vset.find(params[:id])
    @words = Quizlet.find_in_quizlet(params[:search_terms], @vset.id)
    redirect_to @vset
  end
  
  def quiz
    @words = Word.find_all_by_vset_id(params[:vset]).shuffle
    @questions = @words.map { |a| a.name }
    @answers = @words.map { |a| a.definition }
    answer_with_index = @answers.map { |a| 
      Hash[
        @answers.reject { |answer| answer == a }.shuffle[0..2].push(a).
          map.with_index {|ans, index| [ans, index]}.shuffle] 
    }
    
    @answer_choices = answer_with_index.map {|ans| ans.keys}
    @correct_answers = answer_with_index.map {|ans| ans.values.index(3)}
  end
  
  def tagged
    if params[:tag].present? 
      @vsets = Vset.tagged_with(params[:tag])
    else 
      @vsets = Vset.postall
    end  
end
end
