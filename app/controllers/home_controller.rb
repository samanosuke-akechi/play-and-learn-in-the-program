class HomeController < ApplicationController
  def top
    @outputs_list = Output.includes(:user).order("created_at DESC").limit(5)
  end
end