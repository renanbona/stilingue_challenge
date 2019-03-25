FactoryBot.define do
  factory :relationship do
    association :first_word, factory: :word
    association :second_word, factory: :word
  end
end