require 'rails_helper'

describe 'Post to links' do
  context 'url posted for first time' do
    it 'saves to database with read count as 1' do
      url = Faker::Internet.url
      link_params = { link: { url: url } }

      post '/api/v1/links', params: link_params

      expect(response).to be_success
      expect(Link.count).to eq 1
      
      link = Link.first

      expect(link.url).to eq url
      expect(link.read_count).to eq 1
    end
  end

  context 'url posted after first time' do
    it 'increments read count by 1' do
      link = create(:link, read_count: 4)
      link_params = { link: { url: link.url } }

      post '/api/v1/links', params: link_params

      expect(response).to be_success
      expect(Link.count).to eq 1
      
      updated_link = Link.first

      expect(updated_link.url).to eq link.url
      expect(updated_link.read_count).to eq 5
    end
  end

  context 'invalid parameters' do
    it 'returns 400 status' do
      invalid_params = { not_link: { url: 'url' } }

      post '/api/v1/links', params: invalid_params

      expect(response.status).to eq 400
    end
  end
end