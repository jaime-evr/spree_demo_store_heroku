module Api
  class V1::CurrentTimeController < ApplicationController
    skip_before_filter :verify_authenticity_token, only: :create

    def index
      render json: { current_time: Time.now.strftime("%H:%M:%S") }
    end
  end
end
