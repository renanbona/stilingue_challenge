require 'rails_helper'

describe RelatedWordsScraper do
  describe 'related_words' do
    let(:word) { 'amor' }
    let(:related_words) { 
      [
        "afeto",
        "carinho",
        "afeição",
        "simpatia",
        "predileção",
        "inclinação",
        "idolatria",
        "ternura",
        "benevolência",
        "apego",
        "dedicação",
        "ardor",
        "paixão",
        "fervor",
        "calor",
        "devoção",
        "enlevo",
        "arrebatamento",
        "adoração",
        "enlevamento",
        "arroubamento",
        "vôo",
        "quindim",
        "namorada",
        "idolatrado",
        "favorito",
        "estremecido",
        "estimado",
        "doce de coco"
      ]
    }

    subject { described_class.new(word).related_words }

    it 'get the words related on the website' do
      VCR.use_cassette('search_for_love') do
        expect(subject).to eq(related_words)
      end
    end
  end
end