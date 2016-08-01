require 'grape'
require_relative 'clock'
require_relative 'clock_manager'

module Timemachine 
  class Thetime < Grape::API
    version 'v1', using: :path
    format :json

    get 'clock' do
      clock = Clock.new
      {
        actual_time: clock.actual_time
      }
    end

    resource :clock do 
      get '/:name' do 
        clock = ClocksManager.show_clock(params[:name])
        if clock
          return clock
        else
          status 404
        end
      end

      post '/:name' do
        ClocksManager.create_clock(params[:name])
      end

      params do
           requires :actual_time, type: String 
           requires :attempts, type: Integer 
      end

      put '/:name' do
        ClocksManager.update_clock(name: params[:name], attempts: params[:attempts], actual_time: params[:actual_time])
      end

      delete '/:name' do 
        clock = ClocksManager.delete_clock(params[:name])
        status 204
      end
      
    end
  end
end


