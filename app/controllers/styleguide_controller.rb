class StyleguideController < Kss::ApplicationController

  rescue_from ActionView::MissingTemplate, :with => :render_default, :only => :show
  include Kss::StyleguideParser

  def show
    render params[:section]
  end

  private
  def render_default
    @section = params[:section]
    render :default
  end
end
