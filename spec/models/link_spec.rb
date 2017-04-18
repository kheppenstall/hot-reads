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
end
