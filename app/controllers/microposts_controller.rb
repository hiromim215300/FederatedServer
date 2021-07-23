class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      set_micropost
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  def set_micropost
    firestore = Google::Cloud::Firestore.new(
    project_id: "sampleapp-735a6",
    credentials: "config/firebase_auth.json"
    )
    data = {
        context: @micropost.content,
        created_at: @micropost.created_at,
        picture: "picture",
        updated_at: @micropost.updated_at,
        user_id: @micropost.user_id,
        address: @micropost.address
      }
    users_ref = firestore.col("microposts").document(@micropost.address).col("collection")
    added_doc_ref = users_ref.add data
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
