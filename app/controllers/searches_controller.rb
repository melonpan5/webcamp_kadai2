class SearchesController < ApplicationController



  	def index
    #@users = User.where(activated: true).search(params[:search])
    @newbook = Book.new 
    @user_or_book = params[:itemoption]
    @how_search = params[:choice]
		if @user_or_book == "user"
		  @users = User.search(params[:search], @user_or_book, @how_search)
		else
		  @books = Book.search(params[:search], @user_or_book, @how_search)
		end
    end


end
