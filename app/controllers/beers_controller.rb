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

		beer_object = convert_beer(beers[0])
		render json: beer_object
	end

  def get_beers
		begin
			beers = @beer_client.get_beers
		rescue Exception => e
			if e.message == "Beers unreachable"
				return render json: {'message': 'Cannot serve you beers right now'}, status: :service_unavailable
			else
				return render json: {'message': 'Shop is closed'}, status: :internal_server_error
			end
		end

		converted_beers = []
		beers.each do |beer|
			converted_beer = convert_beer(beer)
			converted_beers.push(converted_beer)
		end
		
		render json: converted_beers
	end

  private
  def convert_beer(beer)
		converted_beer = {
			"identifier": beer[:id],
			"name": beer[:name],
			"description": beer[:description]
		}
		return converted_beer
	end
end
