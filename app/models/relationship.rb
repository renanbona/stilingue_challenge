class Relationship < ApplicationRecord
  belongs_to :first_word, class_name: 'Word'
  belongs_to :second_word, class_name: 'Word'
end
