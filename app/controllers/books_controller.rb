class BooksController < ApplicationController
	before_action :ensure_corrent_user, {only: [:edit, :update, :destroy]}
	def create
	@books = Book.all
	@newbook = Book.new(book_params)
	@newbook.user_id = current_user.id
	@user = current_user
	if @newbook.save
	flash[:notice] = "Book was successfully created."
	redirect_to book_path(@newbook.id)
	else
		render 'index'
	end
	end

	def index
	@books = Book.all
	@newbook = Book.new
	@user = current_user
	end

	def show
	@book = Book.find(params[:id])
	@newbook = Book.new
	@user = @book.user
	@book_comment = BookComment.new
	end

	 def edit
	 @book = Book.find(params[:id])
	 end

	 def update
	 @book = Book.find(params[:id])
	if @book.update(book_params)
	 	flash[:notice] = "Book was successfully updated."
	 	redirect_to book_path(@book.id)
	else
		@books = Book.all
		render 'edit'
	 end
	end

	def destroy
	 book = Book.find(params[:id])
	if book.destroy
		flash[:notice] = "Book was successfully destroyed."
		redirect_to books_path
	 else
	 books = Book.all
	 render 'index'
	end
	end
	 private

	 def book_params
	 params.require(:book).permit(:title, :body)
	 end

	 def ensure_corrent_user
        @book = Book.find_by(id: params[:id])
        if @book.user_id != current_user.id
            redirect_to books_path
        end
    end
end
