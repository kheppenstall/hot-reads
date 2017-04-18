class Api::V1::Links::StatusByUrlController < ApplicationController
  def get
    if link = Link.find_by(url: params[:url])
      render json: { url: link.url, status: link.status } 
    else
      render json: {error: 'Not found'}, status: 404
    end
  end
end