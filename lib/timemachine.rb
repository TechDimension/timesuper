require 'grape'
require_relative 'clock'

module Timemachine 
  class Thetime < Grape::API
    version 'v1', using: :path
    format :json

    get :clock do 
      Clock.decrement_attempts
      {
        time: Clock.actual_time,
        attemptsleft: Clock.attempts
      }
    end

    params do
      requires :actual_time, type: String 
      requires :attempts, type: Integer 
    end

    post :clock do
      Clock.actual_time = params[:actual_time]
      Clock.attempts = params[:attempts]
    end

  end
end


