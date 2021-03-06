# frozen_string_literal: true

class WordsController < ApplicationController
  def index; end

  def create
    if params[:name].present?
      word = CreateWordService.perform(params[:name]&.downcase)

      if word.errors.empty?
        @graph_data = WordGraphExporter.perform(word)
        render json: @graph_data
      end
    end
  end

  private

  def word
    Word.find_by(name: params[:id])
  end
end
