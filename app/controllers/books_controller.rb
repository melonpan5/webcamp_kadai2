class BooksController < ApplicationController
   before_action :authenticate_user!



  def index
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @user =current_user
    @newbook = Book.new
  end


  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @user = @book.user
  end

  def new
  end

  def create
  	@newbook = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @newbook.user = current_user
    if @newbook.save #入力されたデータをdbに保存する。
  		redirect_to @newbook, notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
  		render :index
  	end
  end

  def ensure_correct_user
        if @current_user.id !=  params[:id].to_i
         redit_to books_path
        end
    end

  def edit
  	@book = Book.find(params[:id])
    @user = @book.user
    if @user != current_user
      redirect_to books_path
    end
  end


  def update
  	@book = Book.find(params[:id])
    @newbook = Book.new(book_params)
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render :edit
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destoy
  	redirect_to books_path(@book), notice: "successfully delete book!"
  end

end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end


