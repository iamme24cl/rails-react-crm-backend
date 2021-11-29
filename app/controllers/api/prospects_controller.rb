class Api::ProspectsController < ApplicationController
  before_action :find_prospect, only: [:show, :update, :destroy]
  before_action :find_company, only: [:create, :update]

  def index
    @prospects = Prospect.all.order created_at: :desc
    render json: @prospects
  end

  def show
    render json: @prospect
  end

  def create
    prospect = Prospect.new(
      first_name: prospect_params[:first_name],
      last_name: prospect_params[:last_name],
      email: prospect_params[:email]
    )
    prospect.company = @company if @company

    if prospect.save
      render json: prospect, status: :accepted
    else
      render json: { errors: prospect.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def update
    @prospect.update(
      first_name: prospect_params[:first_name],
      last_name: prospect_params[:last_name],
      email: prospect_params[:email]
    )
    @prospect.company = @company if @company

    if @prospect.save
      render json: @prospect, status: :accepted
    else
      render json: { errors: @prospect.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
  end

  private

  def prospect_params
    params.require(:prospect).permit(
      :first_name, :last_name, :email, :phone, :company_id, :company_name)
  end

  def find_prospect
    @prospect = Prospect.find_by(id: params[:id])
  end

  def find_company
    if prospect_params[:company_id] == ""
      @company = Company.find_or_create_by(name: prospect_params[:company_name])
    else
      @company = Company.find(prospect_params[:company_id])
    end
  end
end
