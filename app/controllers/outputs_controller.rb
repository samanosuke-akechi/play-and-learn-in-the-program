class OutputsController < ApplicationController
  before_action :restriction, except: [:index, :show]
  before_action :set_outputs_list, only: [:index, :show]
  
  def index
    @outputs = Output.includes(:user).order("created_at DESC")
  end

  def new
    @output = Output.new
  end

  def create
    @output = Output.new(output_params)
    if @output.valid?
      @output.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @output = Output.find(params[:id])
  end

  def edit
    @output = Output.find(params[:id])
  end

  def update
    @output = Output.find(params[:id])
    if @output.update(output_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    Output.destroy(params[:id])
    redirect_to action: :index
  end

  private

  def output_params
    params.require(:output).permit(:title, :text).merge(user_id: current_user.id)
  end

  def restriction
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def set_outputs_list
    @outputs_list = Output.includes(:user).order("created_at DESC").limit(5)
  end
  
end