require 'rails_helper'

RSpec.describe RecipesImporterService, type: :model do
  describe '#call' do
    let(:import_file) { 'spec/support/mini_import_file.json' }
    it 'will create new recipe records for each line' do
      described_class.call(import_file)
      expect(Recipe.count).to eq(File.readlines(import_file).size)
    end
  end
end