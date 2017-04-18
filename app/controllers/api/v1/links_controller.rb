class Api::V1::LinksController < ApplicationController
  def create
    link = Link.find_or_initialize_by(link_params)
    if link.save && link.add_read
      render json: link
    else
      render json: { error: 'Unable to add read' }, status: 400
    end
  end

  private

    def link_params
      params.require(:link).permit(:url)
    end
end