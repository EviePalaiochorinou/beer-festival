require_relative "../clients/punk_api_client"
class BeersController < ApplicationController
  def initialize()
		@beer_client = PunkAPIClient.new
	end

	def get_beer	
		begin
			beers = @beer_client.get_beer(params[:id])
		rescue Exception => e
			if e.message == "Beer not found"
				return render json: {'message': 'Beer with given id not found'}, status: :not_found
			elsif e.message == "Beers unreachable"
				return render json: {'message': 'Cannot serve you beers right now'}, status: :service_unavailable
			else
				return render json: {'message': 'Shop is closed'}, status: :internal_server_error
			end
		end
		beer_object = (beers[0])
    converted_beer = {
			"identifier": beer_object[:id],
			"name": beer_object[:name],
			"description": beer_object[:description]
		}
		render json: converted_beer
	end

  
end
