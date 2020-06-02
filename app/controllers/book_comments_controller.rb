class BookCommentsController < ApplicationController

	def create
	@book = Book.find(params[:book_id])
	@book_comment = current_user.book_comments.new(book_comment_params)
	@book_comment.book_id = @book.id
		if @book_comment.save
		redirect_to book_path(@book)
		else
	    @newbook = Book.new
	    @user = @book.user
	    render "books/show"
		end

	end

	def destroy
    @book_comment = BookComment.find(params[:id])
    if @book_comment.user != current_user
      redirect_to request.referer
    end
    @book_comment.destroy
    redirect_to request.referer
    
  end


 private
	def book_comment_params
	    params.require(:book_comment).permit(:comment)
	end

end