require 'rails_helper'

RSpec.feature 'Links index' do

  let!(:visible_links) { create_list(:link, 10, read_count: 5) }

  context '10 or less total links' do
    it 'shows all links' do
      visit links_path

      visible_links.each do |link|
        expect(page).to have_content link.url
      end
    end
  end

  context 'more than 10 links' do

    let!(:invisible_links) { create_list(:link, 10, read_count: 4) }

    it 'shows only top ten links' do
      visit links_path

      visible_links.each do |link|
        expect(page).to have_content link.url
      end

      invisible_links.each do |link|
        expect(page).to_not have_content link.url
      end
    end
  end
end
