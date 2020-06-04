class UsersController < ApplicationController
	before_action :baria_user, only: [:update, :destroy]
  before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@newbook = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@user = User.find(current_user.id)
    @newbook = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def edit
  	@user = User.find(params[:id])
    if @user.id != current_user.id
    redirect_to user_path(current_user)
    end
  end

  def update
  	@user = User.find(params[:id])
    @newbook = Book.new
    @books = @user.books
  	if @user.update(user_params)
  		redirect_to  @user, notice: "successfully updated user!"
  	else
  		render :show
  	end
  end

 def destroy
       @user = User.find(params[:id])
     if @user.destroy
      redirect_to homes
      flash[:notice] = 'Signed out successfully'
     else
      render :show
     end
  end

# フォローフォロワー一覧ページ用
   def follows
      @user  = User.find(params[:id])
      @users = @user.follows
      render 'follows'
    end

    def followers
      @user  = User.find(params[:id])
      @users = @user.followers
      render 'followers'
    end


  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
   end

   protected
    # アカウント編集後、マイページへに移動する
  def after_update_path_for(resource)
      user_path(id: current_user.id)
  end

end
