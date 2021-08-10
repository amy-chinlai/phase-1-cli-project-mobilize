require "spec_helper"

describe "#parsed_url" do
it "takes in an argument of a zip code, parses that into lat/long coordinates, and outputs a url containing the lat and long." do 
  expect(@url).to eq(["https://www.mobilize.us/?address=20010&lat=38.93331077306183lon=-77.02894271253064&show_all_events=true"])
end 

describe ".scrape_opportunities_page" do
    it "creates and returns a hash of the name, date, and location of the opportunity." do 
        expect(@info_hash).hash.first.to eq(['{"name": "Swing Left Columbia Heights: Virginia Kick-off Party!"}'])
    end
end

end