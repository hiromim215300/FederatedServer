class ServersController < ApplicationController
  def index
    @server = Server.paginate(page: params[:page])
  end
end
