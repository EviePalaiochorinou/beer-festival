class PunkAPIClient
	@@base_url = "https://api.punkapi.com/v2"

	def get_beer(id)
		suffix = "/beers/#{id}"
		begin
			response = RestClient.get(@@base_url+suffix)
		rescue RestClient::NotFound => e
			raise Exception.new "Beer not found"
		rescue RestClient::InternalServerError => e
			raise Exception.new "Beers unreachable"
		end
		beers = JSON.parse(response.body, {:symbolize_names => true})
	end

end