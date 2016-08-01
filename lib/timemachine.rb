require 'grape'
require_relative 'clock'
require_relative 'clock_manager'

module Timemachine 
  class Thetime < Grape::API
    version 'v1', using: :path
    format :json

    resource :clock do 
      get '/:name' do 
        ClocksManager.show_clock(params[:name])
      end

      post '/:name' do
        ClocksManager.create_clock(params[:name])
      end

      put '/:name' do
        ClocksManager.update_clock(name: params[:name], attempts: params[:attempts], actual_time: params[:actual_time])
      end
      delete '/:name' do 
        ClocksManager.delete_clock(params[:name])
      end
    end
  end
end


