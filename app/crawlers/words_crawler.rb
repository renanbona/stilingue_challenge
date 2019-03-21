require 'nokogiri'
require 'open-uri'

def find_word
  url = Nokogiri::HTML(open('https://dicionariocriativo.com.br/amor'))

  word = url.xpath('//h1').text

  related_words = url.at_css('.tags').children

  related_words.each do |word|
    puts word.text
  end
end

url = Nokogiri::HTML(open("https://dicionariocriativo.com.br/indice-de-palavras/a"))
list = url.at_css('[id="indexList"]')