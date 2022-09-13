require_relative '../test_helper'
require_relative '../../app/clients/punk_api_client'
require 'rails_helper'

RSpec.describe 'Beers', :type => :request do

  # I did not put the client double into a before block, since some doubles return different results
  
  describe 'get /beers' do
    let (:beer_client) {instance_double(PunkAPIClient, :get_beers => [{"id":1,"name":"Buzz","tagline":"A Real Bitter Experience.","first_brewed":"09/2007","description":"A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.","image_url":"https://images.punkapi.com/v2/keg.png","abv":4.5,"ibu":60,"target_fg":1010,"target_og":1044,"ebc":20,"srm":10,"ph":4.4,"attenuation_level":75,"volume":{"value":20,"unit":"litres"},"boil_volume":{"value":25,"unit":"litres"},"method":{"mash_temp":[{"temp":{"value":64,"unit":"celsius"},"duration":75}],"fermentation":{"temp":{"value":19,"unit":"celsius"}},"twist":nil},"ingredients":{"malt":[{"name":"Maris Otter Extra Pale","amount":{"value":3.3,"unit":"kilograms"}},{"name":"Caramalt","amount":{"value":0.2,"unit":"kilograms"}},{"name":"Munich","amount":{"value":0.4,"unit":"kilograms"}}],"hops":[{"name":"Fuggles","amount":{"value":25,"unit":"grams"},"add":"start","attribute":"bitter"},{"name":"First Gold","amount":{"value":25,"unit":"grams"},"add":"start","attribute":"bitter"},{"name":"Fuggles","amount":{"value":37.5,"unit":"grams"},"add":"middle","attribute":"flavour"},{"name":"First Gold","amount":{"value":37.5,"unit":"grams"},"add":"middle","attribute":"flavour"},{"name":"Cascade","amount":{"value":37.5,"unit":"grams"},"add":"end","attribute":"flavour"}],"yeast":"Wyeast 1056 - American Ale™"},"food_pairing":["Spicy chicken tikka masala","Grilled chicken quesadilla","Caramel toffee cake"],"brewers_tips":"The earthy and floral aromas from the hops can be overpowering. Drop a little Cascade in at the end of the boil to lift the profile with a bit of citrus.","contributed_by":"Sam Mason <samjbmason>"}])}
    
    it 'returns all beers' do
      allow(PunkAPIClient).to receive(:new).and_return(beer_client)
      get "/beers"
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body,  {:symbolize_names => true})).to eq([{"identifier":1, "name":"Buzz", "description":"A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once."}])
    end
  end

  describe 'get a beer with a given id' do
    let (:beer_client) {instance_double(PunkAPIClient, :get_beer => [{"id":1,"name":"Buzz","tagline":"A Real Bitter Experience.","first_brewed":"09/2007","description":"A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.","image_url":"https://images.punkapi.com/v2/keg.png","abv":4.5,"ibu":60,"target_fg":1010,"target_og":1044,"ebc":20,"srm":10,"ph":4.4,"attenuation_level":75,"volume":{"value":20,"unit":"litres"},"boil_volume":{"value":25,"unit":"litres"},"method":{"mash_temp":[{"temp":{"value":64,"unit":"celsius"},"duration":75}],"fermentation":{"temp":{"value":19,"unit":"celsius"}},"twist":nil},"ingredients":{"malt":[{"name":"Maris Otter Extra Pale","amount":{"value":3.3,"unit":"kilograms"}},{"name":"Caramalt","amount":{"value":0.2,"unit":"kilograms"}},{"name":"Munich","amount":{"value":0.4,"unit":"kilograms"}}],"hops":[{"name":"Fuggles","amount":{"value":25,"unit":"grams"},"add":"start","attribute":"bitter"},{"name":"First Gold","amount":{"value":25,"unit":"grams"},"add":"start","attribute":"bitter"},{"name":"Fuggles","amount":{"value":37.5,"unit":"grams"},"add":"middle","attribute":"flavour"},{"name":"First Gold","amount":{"value":37.5,"unit":"grams"},"add":"middle","attribute":"flavour"},{"name":"Cascade","amount":{"value":37.5,"unit":"grams"},"add":"end","attribute":"flavour"}],"yeast":"Wyeast 1056 - American Ale™"},"food_pairing":["Spicy chicken tikka masala","Grilled chicken quesadilla","Caramel toffee cake"],"brewers_tips":"The earthy and floral aromas from the hops can be overpowering. Drop a little Cascade in at the end of the boil to lift the profile with a bit of citrus.","contributed_by":"Sam Mason <samjbmason>"}])}
    
    it 'returns a single beer' do
      expect(PunkAPIClient).to receive(:new).and_return(beer_client)
      get "/beers/1"
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body,  {:symbolize_names => true})).to eq({"identifier":1, "name":"Buzz", "description":"A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once."})
    end
    
    let (:beer_client2) {instance_double(PunkAPIClient, :get_beer => [])}
    
    it 'returns not found message and code when beer with given id not found' do
      allow(PunkAPIClient).to receive(:new).and_return(beer_client2)
      allow(beer_client2).to receive(:get_beer).with("10000").and_raise(Exception, "Beer not found")
      get "/beers/10000"
      expect(response).to have_http_status(404)
      expect(JSON.parse(response.body,  {:symbolize_names => true})).to eq({'message': 'Beer with given id not found'})
    end
  end

  describe 'get a beer with a given name' do
    let (:beer_client) {instance_double(PunkAPIClient, :get_beers => [{"id":1,"name":"Buzz","tagline":"A Real Bitter Experience.","first_brewed":"09/2007","description":"A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.","image_url":"https://images.punkapi.com/v2/keg.png","abv":4.5,"ibu":60,"target_fg":1010,"target_og":1044,"ebc":20,"srm":10,"ph":4.4,"attenuation_level":75,"volume":{"value":20,"unit":"litres"},"boil_volume":{"value":25,"unit":"litres"},"method":{"mash_temp":[{"temp":{"value":64,"unit":"celsius"},"duration":75}],"fermentation":{"temp":{"value":19,"unit":"celsius"}},"twist":nil},"ingredients":{"malt":[{"name":"Maris Otter Extra Pale","amount":{"value":3.3,"unit":"kilograms"}},{"name":"Caramalt","amount":{"value":0.2,"unit":"kilograms"}},{"name":"Munich","amount":{"value":0.4,"unit":"kilograms"}}],"hops":[{"name":"Fuggles","amount":{"value":25,"unit":"grams"},"add":"start","attribute":"bitter"},{"name":"First Gold","amount":{"value":25,"unit":"grams"},"add":"start","attribute":"bitter"},{"name":"Fuggles","amount":{"value":37.5,"unit":"grams"},"add":"middle","attribute":"flavour"},{"name":"First Gold","amount":{"value":37.5,"unit":"grams"},"add":"middle","attribute":"flavour"},{"name":"Cascade","amount":{"value":37.5,"unit":"grams"},"add":"end","attribute":"flavour"}],"yeast":"Wyeast 1056 - American Ale™"},"food_pairing":["Spicy chicken tikka masala","Grilled chicken quesadilla","Caramel toffee cake"],"brewers_tips":"The earthy and floral aromas from the hops can be overpowering. Drop a little Cascade in at the end of the boil to lift the profile with a bit of citrus.","contributed_by":"Sam Mason <samjbmason>"}])}
    it 'returns success' do
      allow(PunkAPIClient).to receive(:new).and_return(beer_client)
      get "/beers", :params => { :name => "Buzz" }
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(JSON.parse(response.body,  {:symbolize_names => true})).to eq([{"identifier":1, "name":"Buzz", "description":"A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once."}])
    end

    let (:beer_client2) {instance_double(PunkAPIClient, :get_beers => [])}
    it 'returns empty results' do
      allow(PunkAPIClient).to receive(:new).and_return(beer_client2)
      get "/beers", :params => { :name => "no beer with such name" }
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(JSON.parse(response.body,  {:symbolize_names => true})).to eq([])
    end
  end
  
  describe 'api is unreachable' do
    let (:beer_client) {instance_double(PunkAPIClient, :get_beers => [])}

    it 'returns unreachable message' do
      allow(PunkAPIClient).to receive(:new).and_return(beer_client)
      allow(beer_client).to receive(:get_beers).and_raise(Exception, "Beers unreachable")
      get "/beers"
      expect(JSON.parse(response.body,  {:symbolize_names => true})).to eq({'message': 'Cannot serve you beers right now'})
      expect(response).to have_http_status(503)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end
end