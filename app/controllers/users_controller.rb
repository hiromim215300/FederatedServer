class UsersController < ApplicationController
require "google/cloud/firestore"
firestore = Google::Cloud::Firestore.new(
  project_id: "sampleapp-735a6",
  credentials: "config/firebase_auth.json"
)

before_action :logged_in_user, only:[:index, :edit, :update, :destroy,
				     :following, :followers]
before_action :correct_user, only: [:edit, :update]
before_action :admin_user, only: :destroy
#before_action :update_address

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
   @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      set_user
      set_server
     # write
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render ‘edit’
    end
   end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

    def set_user
      firestore = Google::Cloud::Firestore.new(
      project_id: "sampleapp-735a6",
      credentials: "config/firebase_auth.json"
      )
      data = {
          name: @user.name,
          email: @user.email,
          address: @user.address,
          password_digest: @user.password_digest,
          remember_digest: @user.remember_digest,
          activated: @user.activated,
          activated_at: @user.activated_at,
          activation_digest: @user.activation_digest,
          updated_at: @user.updated_at,
          created_at: @user.created_at,
          admin: @user.admin
        }
      users_ref = firestore.collection('users').document(@user.address).collection("collection")
      added_doc_ref = users_ref.add data
    end

    def set_server
      firestore = Google::Cloud::Firestore.new(
      project_id: "sampleapp-735a6",
      credentials: "config/firebase_auth.json"
      )
      data = {
          id: @user.id,
          name: @user.address
        }
      users_ref = firestore.collection('servers').document(@user.address)
      added_doc_ref = users_ref.set data
    end

  private
    def write
       firestore = Google::Cloud::Firestore.new(project_id: 'sampleapp-735a6', credentials: 'config/firebase_auth.json')  # firestreインスタンスを作成
       doc_ref = firestore.col("users").doc("user") # 保存先のパスを指定
       doc_ref.set({id: "1", name: "user"}) # 値を書き込む     
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def update_address
      if logged_in?
         udp = UDPSocket.new
         udp.connect("128.0.0.0", 7)
         adrs = Socket.unpack_sockaddr_in(udp.getsockname)[1]
         @user = User.find(params[:id])
         @user.address = adrs
         @user.save
      end 
    end
end
