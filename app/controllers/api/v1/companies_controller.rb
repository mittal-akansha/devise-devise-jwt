class Api::V1::CompaniesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_company,only: [:show,:edit,:destroy]

  def index
    # @companies=Company.all
    @companies=current_user.companies
    render json: @companies,status: :ok
  end
  def show
    render json: @company ,status: :ok
  end

  def create
    company_create=current_user.companies.create(company_params)
    if company_create.save!
      render json: company_create , status: :ok
    else  
      render json: {status:{code: 400 ,message: "the company is not created successfully"}}
    end
  end

  def update
    update_company=current_user.companies.update(company_params)
    if update_company.save!
      render json: update_company , status: :ok
    else 
      render json: {status:{code: 400 ,message: "the company is not updated successfully"}}
    end
  end

  def destroy
    if current_user.companies.destroy
     render json: current_user.companies ,status: :ok
    else
     render json: {status: {code: "400",message:"the companies destroy is not successfully"}}
    end
  end

  private
  def set_company
    @company=current_user.companies.find(params[:id])
  rescue ActiveRecord::RecordNotFound => errors
    render json: error.messages, status: :unauthorized
  end
  
  def company_params
    params.require(:company).permit(:name,:address,:established_date)
  end
end
