require 'nokogiri'
require 'open-uri'

class FetchWords
  def initialize(word)
    @word = word
  end

  def self.build_info(word)
    new(word).build_info
  end

  def build_info
    {
      related_words: related_words
    }
  end

  private

  def related_words
    url
      .at_css('.tags')
      .children
      .map { |word| word.text }
  end

  def url
    @url ||= Nokogiri::HTML page
  end

  def page
    open("https://dicionariocriativo.com.br/#{@word}")
  end

  def word
    "#{@word}"
  end
end
