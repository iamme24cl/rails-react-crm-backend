class Api::CompaniesController < ApplicationController
  before_action :find_company, only: [:update, :destroy]

  def index
    @companies = Company.all.order created_at: :desc
    render json: @companies
  end

  def create
    company = Company.new(company_params)
    if company.save
      render json: company, status: :accepted
    else
      render json: { errors: company.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def update
    @company.update(company_params)
    if @company.save
      render json: @company, status: :accepted
    else
      render json: { errors: @company.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    company_id = @company.id
    name = @company.name
    @company.destroy

    render json: { message: "Deleted company #{name} with id #{company_id}"}, status: :accepted
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end

  def find_company
    @company = Company.find_by(id: params[:id])
  end
end
