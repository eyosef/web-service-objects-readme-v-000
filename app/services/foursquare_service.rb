class FoursquareService 
    def authenticate!(client_id, client_secret, code)
        resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
          req.params['client_id'] = ENV['FOURSQUARE_CLIENT_ID']
          req.params['client_secret'] = ENV['FOURSQUARE_SECRET']
          req.params['grant_type'] = 'authorization_code'
          req.params['redirect_uri'] = "http://localhost:3000/auth"
          req.params['code'] = params[:code]
        end
    
        body = JSON.parse(resp.body)
        body["access_token"]
      end

    def friends(token)
        resp = Faraday.get("https://api.foursquare.com/v2/users/self/friends") do |req|
          req.params['oauth_token'] = token
          req.params['v'] = '20160201'
        end
        JSON.parse(resp.body)["response"]["friends"]["items"]
    end

    def foursquare(token)
        @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
            req.params['client_id'] = client_id
            req.params['client_secret'] = client_secret
            req.params['v'] = '20160201'
            req.params['near'] = params[:zipcode]
            req.params['query'] = 'coffee shop'
        end
    
        body = JSON.parse(@resp.body)
    end 
end 