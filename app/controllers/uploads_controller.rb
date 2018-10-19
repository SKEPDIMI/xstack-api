class UploadsController < ApplicationController
  before_action :authenticate_user!, only: :user_img
  
  def user_img
    render json: { data: 'Hey!' }, status: :ok
  end
end
