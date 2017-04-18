require 'rails_helper'

RSpec.describe Link, type: :model do

  let(:link) { create(:link) }

  context 'validations' do
    it { is_expected.to validate_presence_of :url }
    it { is_expected.to validate_uniqueness_of :url }
    it { is_expected.to validate_presence_of :read_count }
  end

  context '#read_count' do
    it 'defaults to 0' do

      expect(link.read_count).to eq 0
    end
  end

  context '#add_read' do
    it 'increments read count by 1' do
      link.add_read
      link.reload

      expect(link.read_count).to eq 1
    end
  end

  context '.top_ten' do

    before do
      20.times { |n| create(:link, read_count: n) }
    end

    it 'returns top ten links by read count' do
      top_links = Link.top_ten

      expect(top_links).to be_an Array
      expect(top_links.length).to eq 10

      top_links.each { |link| expect(link.read_count).to be >= 10 }

      sorted = top_links.sort_by { |link| -link.read_count }

      expect(top_links).to eq sorted
    end
  end
end
