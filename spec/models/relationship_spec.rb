require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe "assotiations" do
    it { is_expected.to belong_to(:first_word) } 
    it { is_expected.to belong_to(:second_word) } 
  end
end
