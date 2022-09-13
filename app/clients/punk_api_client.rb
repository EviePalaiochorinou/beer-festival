# A class wrapper around PunkAPI resful sevice
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

	# Supports retrieval of both all beers and filtered beer set
	def get_beers(with_name=nil)
		params = {}
		if !with_name.nil?
			params = {'beer_name': with_name}
		end
		begin
			response = RestClient.get(@@base_url+"/beers", {params: params})
		rescue RestClient::InternalServerError => e
			raise Exception.new "Beers unreachable"
		end
		beers = JSON.parse(response.body, {:symbolize_names => true})
end
end