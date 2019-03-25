# frozen_string_literal: true

class WordsController < ApplicationController
  def index; end

  def show
    @graph_data = WordGraphExporter.perform(word)
    render json: @graph_data
  end

  def create
    unless params[:name].empty?
      word = CreateWordService.perform(params[:name]&.downcase)

      if word.errors.empty?
        @graph_data = WordGraphExporter.perform(word)
        render(&:js)
      end
    end
  end

  private

  def word
    Word.find_by(name: params[:id])
  end
end
