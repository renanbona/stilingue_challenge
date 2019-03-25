require 'nokogiri'
require 'open-uri'

class RelatedWordsScraper
  def initialize(word)
    @word = word
  end

  def related_words
    words = url
      .at_css('.tags')
      &.children
      &.map(&:text) || []
    words - [@word]
  end

  private

  def url
    @url ||= Nokogiri::HTML(page)
  end

  def page
    url = URI.encode("https://dicionariocriativo.com.br/#{@word}")
    open(url)
  end
end