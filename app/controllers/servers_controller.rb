class ServersController < ApplicationController
  def index
    @servers = Server.paginate(page: params[:page])
  end

  def show
    @server = 
  end
end
