class Api::V1::BooksController < ApplicationController
  include I18n
  before_action :authenticate_user!
  before_action :set_book , only: [:show , :update, :destroy ]
  before_action :set_locale, only: [:show]

 def index 
   @books=Book.all
   render json: @books
 end
 
 def show
  #  render json: @book , status: :ok
   render json: {message: I18n.t('api.hello',title: @book.title)}
 end

 def create
   book=Book.create(book_params)
   if can? :index,book
     if book.save!
       render json: {status: {code:"200",message:"book created successfully",data:book}} , status: :ok
     else
       render json: {status: {code: "400",message: "book noyt created successfully"}},status: :unprocessable_entity
     end
   else
     render json: {message:"you have not access to see all users"}
   end 
 end

 def update
   book=@book.update(book_params)
   if can? :index,book
     if book.save!
       render json: {status: {code:"200",message:"book update successfully",data:book}}
     else 
       render json: {status: {code:"400",message:"book not update successfully"}}, status: :unprocessable_entity
     end
   else
     render json: {message:"you have not access to see all users"}
   end 
 end 

 def destroy
   if can? :index,@book
     if @book.destroy
       render json:  {status: {code:"200",message:"book deleted successfully",data:@book}} 
      else
      render json: {status: {code:"400",message:"book not created successfully"}}, status: :unprocessable_entity
      end
   else
     render json: {message:"you have not access to see all users"}
   end 
 end

 private 
 def set_book
   @book=Book.find_by(params[:id])
 end

 def book_params
   params.require(:book).permit(:title,:genre,:published_date,:price,:language,:author_id)
 end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
