class Scraper

    def get_page
        Nokogiri::HTML(open(Scraper.parsed_url(zip_input)))
    end

    def self.parsed_url(zip_input)
        coordinates = Geocoder.search(zip_input).first.coordinates
        latitude = coordinates[0]
        longitude = coordinates[1]
        url = "https://www.mobilize.us/?address=#{zip_input}&lat=#{latitude}lon=#{longitude}&show_all_events=true"
        url
    end

    def make_opportunities
        @opportunities.each {|opportunity| Opportunity.new_from_page(opportunity)}
    end



    def self.scrape_opportunities_page
        opportunities_list = get_page.css(".css-19fddw")
        @opportunites = []
        opportunities_list.each do |opportunity|
            info_hash = Hash.new
            info_hash[:name] = doc.css(".css-1i6gh54")
            info_hash[:date] = doc.css(".e1olnexu5")
            info_hash[:location] = doc.css(".e1olnexu14")
            @opportunities << info_hash
        end
        @opportunities
    end



end