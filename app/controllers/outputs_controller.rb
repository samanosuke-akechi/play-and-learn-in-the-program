class OutputsController < ApplicationController
  before_action :restriction, except: [:index, :show]
  before_action :set_outputs_list, only: [:index, :show]
  before_action :set_output, only: [:show, :edit, :update]
  
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
      output = Output.order(created_at: :desc).limit(1)
      redirect_to output_path(output.ids)  # output_path(output[0][:id])と書き換えることもできる
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
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

  def set_output
    @output = Output.find(params[:id])
  end
  
end