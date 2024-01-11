class MembersController < ApplicationController
  before_action :authenticate_user!
  def index
    @members= User.where(role: "customer")
    if can? :index,@members
      render json: @members ,status: :ok
    else
      render json: {message:"you have not access to see all users"}
    end 
  end
end
