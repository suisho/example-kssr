class StyleguideController < Kss::ApplicationController
  def show
    render params[:section]
  end
end
