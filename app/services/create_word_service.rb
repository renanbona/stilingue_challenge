class CreateWordService
  def initialize(params = {})
    @name = params.fetch(:name)
  end

  def self.perform(params = {})
    new(params).perform
  end

  def perform
    @word = Word.find_or_create_by(name: name)

    create_relationships
  end

  def create_relationships
    related_words.each do |word|
      @word_related = Word.find_or_create_by(name: word)
      if @word_related.id != @word.id
        Relationship.create(
          first_word: @word, 
          second_word: @word_related
        )
      end
    end
    @word
  end

  private

  def name
    @name
  end

  def related_words
    words = FetchWords.build_info(name)
    words[:related_words]
  end
end
