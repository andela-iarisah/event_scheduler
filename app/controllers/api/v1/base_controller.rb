class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json

  skip_before_action :authenticate_user!
end
