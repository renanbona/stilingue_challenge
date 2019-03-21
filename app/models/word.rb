class Word < ApplicationRecord
  has_many :first_word_associations, foreign_key: :first_word_id,
    class_name: 'Relationship'
  has_many :first_associations, through: :first_word_associations,
    source: :second_word
  has_many :second_word_associations, foreign_key: :second_word_id,
    class_name: 'Relationship'
  has_many :second_associations, through: :second_word_associations,
    source: :first_word

  validates :name, presence: true

  def associations
    (first_associations + second_associations).flatten.uniq
  end
end
