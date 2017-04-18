class LinksController < ApplicationController

  def index
    @links = Link.top_ten
  end
end