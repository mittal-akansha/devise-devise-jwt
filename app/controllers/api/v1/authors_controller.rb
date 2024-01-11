class Api::V1::AuthorsController < ApplicationController
   before_action :authenticate_user!
   before_action :set_author , only: [:show , :update, :destroy ]
  def index 
    @authors=Author.all
    render json: @authors
  end
  
  def show
    render json: @author , status: :ok
  end

  def create
    author=Author.create(author_params)
    if can? :index,author
      if author.save!
        render json: {status: {code:"200",message:"author created successfully",data:author}} , status: :ok
      else
        render json: {status: {code: "400",message: "author not created successfully"}},status: :unprocessable_entity
      end
    else
      render json: {message:"you have not access to see all users"}
    end 
  end

  def update
    
    author=@author.update(author_params)
    if can? :index,author
      if author.save!
        render json: {status: {code:"200",message:"author update successfully",data:author}}
      else 
        render json: {status: {code:"400",message:"author not update successfully"}}, status: :unprocessable_entity
      end
    else
      render json: {message:"you have not access to see all users"}
    end 
  end 

  def destroy
    if can? :index,@author
      if @author.destroy
        render json:  {status: {code:"200",message:"author deleted successfully",data:@author}} 
       else
       render json: {status: {code:"400",message:"author not created successfully"}}, status: :unprocessable_entity
       end
    else
      render json: {message:"you have not access to see all users"}
    end 
  end

  private 
  def set_author
    @author=Author.find_by(params[:id])
  end

  def author_params
    params.require(:author).permit(:name)
  end
end
