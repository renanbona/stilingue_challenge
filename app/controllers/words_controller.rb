class WordsController < ApplicationController
  before_action :set_word, only: :show

  def index 
    @words = if params[:term]
      Word.where('name LIKE ?', "%#{params[:term]}%")
    else
      @words = Word.all
    end
  end

  def show
  end

  def new
    @word = Word.new
  end

  def create
    @word = CreateWordService.perform(word_params)

    unless @word.errors.any?
      redirect_to word_path(@word)
    else
      render :new
    end
  end
  
  private

  def word_params
    params.require(:word).permit(:name)
  end

  def set_word
    @word = Word.find(params[:id])
  end
end
