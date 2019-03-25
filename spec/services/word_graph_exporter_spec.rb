require 'rails_helper'

describe WordGraphExporter do
  describe '.perform' do
    context 'When the word the searched word has related words' do
      let!(:word) { create(:word) }
      let!(:word2) { create(:word, name: 'carinho') }
      let!(:word3) { create(:word, name: 'afeto') }
      let!(:word4) { create(:word, name: 'apego') }
      let!(:relationship) { create(:relationship, first_word: word, second_word: word2) }
      let!(:relationship2) { create(:relationship, first_word: word, second_word: word3) }
      let!(:relationship3) { create(:relationship, first_word: word, second_word: word4) }
      let(:words_graph) {
        {
          :nodes=>[
            {:id=>"carinho"},
            {:id=>"afeto"}, 
            {:id=>"apego"}, 
            {:id=>"amor", :main=>true}
          ],
          :links=>[
            {:source=>"amor", :target=>"carinho"}, 
            {:source=>"amor", :target=>"afeto"}, 
            {:source=>"amor", :target=>"apego"}
          ]
        }
      }

      it 'generates the word graph' do
        expect(described_class.perform(word)).to eq(words_graph)
      end
    end

    context 'When the word the searched word does not have related words' do
      let!(:word) { create(:word, name: 'abacate') }
      let(:words_graph) {
        {
          :nodes=>[ {:id=>"abacate", :main=>true} ], 
          :links=>[]
        }
      }

      it 'generates the word graph with just one node' do
        described_class.perform(word)

        expect(described_class.perform(word)).to eq(words_graph)
      end
    end
  end
end