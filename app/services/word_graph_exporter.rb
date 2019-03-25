class WordGraphExporter
  def initialize(word)
    @word = word
  end

  def self.perform(word)
    new(word).perform
  end

  def perform
    words_graph
  end

  private

  def words_graph
    graph = related_words
      .each_with_object(nodes: [], links: []) do |related_word, result|
        result[:nodes] << { id: related_word.name }
        result[:links] << { source: @word.name, target: related_word.name }
        
        related_word.associations.each do |second_level_association|
          next unless related_words_names.include?(second_level_association.name)

          result[:links] << {
            source: related_word.name, 
            target: second_level_association.name 
          }
        end
      end

    graph[:nodes] << { id: @word.name, main: true }
    graph
  end

  def related_words
    @word.associations
  end
  
  def related_words_names
    related_words.map(&:name)
  end
end