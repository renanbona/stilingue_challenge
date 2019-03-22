class WordsController < ApplicationController

  def show
    @word = word
    @graph_data = WordGraphExporter.perform(word)
  end

  def new
    @word = Word.new
  end

  def create
    word = CreateWordService.perform(word_params[:name])

    unless word.errors.any?
      redirect_to word_path(word)
    else
      redirect_to new_word_path
    end
  end
  
  private

  def word_params
    params.require(:word).permit(:name)
  end

  def word
    Word.find_by(name: params[:id])
  end
end
