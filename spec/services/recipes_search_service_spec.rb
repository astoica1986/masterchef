require 'rails_helper'

RSpec.describe RecipesSearchService, type: :model do
  before(:all) do
    RecipesImporterService.call('spec/support/mini_import_file.json')
  end
  describe '#call' do
    it 'will return no results if a content search field is not provided' do
      search_result = described_class.call({rate: 3.0, total_time: 20}, 'rank desc')
      expect(search_result.to_a).to eq([])
    end

    it 'will return results if a content search field is provided' do
      search_result = described_class.call({content: 'pomme'}, 'rank desc')
      expect(search_result.count).to eq(2)
    end

    it 'will return more results if a content search field has more words and any of the words match records' do
      search_result = described_class.call({content: 'pomme boeuf'}, 'rank desc')
      expect(search_result.count).to eq(5)
    end

    it 'will return less results if other filters are added beside the content filter' do
      search_result = described_class.call({content: 'pomme boeuf', rate: 3.0, total_time: 20}, 'rank desc')
      expect(search_result.count).to eq(1)
    end
  end
end