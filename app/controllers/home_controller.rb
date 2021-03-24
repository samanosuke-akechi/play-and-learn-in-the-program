class HomeController < ApplicationController
  def top
    @outputs = Output.includes(:user).order("created_at DESC").limit(5)
  end
end
