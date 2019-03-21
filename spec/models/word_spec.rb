require 'rails_helper'

RSpec.describe Word, type: :model do
  describe "validates" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
