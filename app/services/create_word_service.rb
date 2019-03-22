class CreateWordService
  def initialize(name, levels)
    @name = name
    @levels = levels
  end

  def self.perform(name, levels: 1)
    new(name, levels).perform
  end

  def perform
    @word = Word.find_or_create_by(name: @name)

    create_relationships! if @levels.positive?

    @word
  end

  private

  def create_relationships!
    if @word.associations.length < 5
      related_words.each do |word_name|
        related_word = Word.find_or_create_by(name: word_name)
        Relationship.find_or_create_by(
          first_word: @word,
          second_word: related_word
        )
      end
    end

    @word.associations.each do |word|
      CreateWordService.perform(word.name, levels: @levels - 1)
    end
  end

  def related_words
    RelatedWordsScrapper.new(@name).related_words
  end
end
