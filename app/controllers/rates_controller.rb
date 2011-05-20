class RatesController < ApplicationController
  def create
    @user = User.find(params[:id])
    @rate = @user.rates.create(params[:rates])
    redirect_to(user_path)
  end
end