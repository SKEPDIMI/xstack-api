require 'rails_helper'
include ActionController::RespondWith

describe 'POST /upload/user', type: :request do
  # POST for unexistent user
    # it should return :not_found
  # POST without authentication
    # it should return :unauthorized
  # POST for existent user with incorrect auth
    # it should return :unauthorized
  # POST with authentication
    # with file
      # it should return :success
      # we should find img changed in user
      # we should find AWS object with user.img
    # without file
      # it should return :unprocessable_entity
end
