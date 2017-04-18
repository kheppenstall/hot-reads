require 'rails_helper'

describe 'Find link' do

  let!(:hot_read)      { create(:link, read_count: 20) }
  let!(:top_read)      { create(:link, read_count: 25) }
  let!(:not_hot_read)  { create(:link, read_count: 5 )}

  let!(:hot_reads)     { create_list(:link, 8, read_count: 15) }
  let!(:not_hot_reads) { create_list(:link, 9, read_count: 10) }

  context 'not a hot read' do
    it 'returns not hot' do
      url = not_hot_read.url
      link_params = {url: url }
      get '/api/v1/links/status_by_url', params: link_params

      expect(response).to be_success
      raw_read = JSON.parse(response.body)

      expect(raw_read).to be_a Hash
      expect(raw_read['url']).to eq url
      expect(raw_read['status']).to eq 'not hot'
    end
  end

  context 'hot read' do
    it 'returns hot read' do
      url = hot_read.url
      link_params = {url: url }
      get '/api/v1/links/status_by_url', params: link_params

      expect(response).to be_success
      raw_read = JSON.parse(response.body)

      expect(raw_read).to be_a Hash
      expect(raw_read['url']).to eq url
      expect(raw_read['status']).to eq 'hot read'
    end
  end

  context 'top read' do
    it 'returns top read' do
      url = top_read.url
      link_params = {url: url }
      get '/api/v1/links/status_by_url', params: link_params

      expect(response).to be_success
      raw_read = JSON.parse(response.body)

      expect(raw_read).to be_a Hash
      expect(raw_read['url']).to eq url
      expect(raw_read['status']).to eq 'top read'
    end
  end

  context 'invalid params' do
    context 'no url param' do
      it 'returns 404' do
        invalid_params = { not_url: not_hot_read.url }
        get '/api/v1/links/status_by_url', params: invalid_params

        expect(response.status).to eq 404
      end
    end

    context 'no match to url' do
      it 'returns 404' do
        invalid_params = { url: 'not in database' }
        get '/api/v1/links/status_by_url', params: invalid_params

        expect(response.status).to eq 404
      end
    end
  end
end