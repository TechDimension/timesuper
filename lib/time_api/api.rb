require 'grape'
require_relative '../clock'
require_relative '../clock_collection'
require_relative '../my_logger'

module TimemachineAPI
  class Thetime < Grape::API
    version 'v1', using: :path
    format :json

    get 'clock' do
      MyLogger.debug ("Showing Global Time")
      clock = Clock.new
      MyLogger.info ("Global Time showed")
      {
        actual_time: clock.actual_time
      }
    end

    resource :clock do 
      get '/:name' do
        MyLogger.debug ("Showing Time of clock with name: #{params[:name]}")
        clock = ClocksCollection.show_clock(params[:name])
        if clock
          return clock
        else
          status 404
          body "404: No clock with name: #{params[:name]}"
        end
      end

      post '/:name' do
        MyLogger.debug("Creating new clock with name: #{params[:name]}")
        ClocksCollection.create_clock(params[:name])
      end

      params do
           requires :actual_time, type: String 
           requires :attempts, type: Integer 
      end

      put '/:name' do
        MyLogger.debug("Updating clock with name: #{params[:name]}")
        ClocksCollection.update_clock(name: params[:name], attempts: params[:attempts], actual_time: params[:actual_time])
      end

      delete '/:name' do 
        MyLogger.debug("Deleting clock with name: #{params[:name]}")
        clock = ClocksCollection.delete_clock(params[:name])
        status 204
      end 
    end
  end
end


