class Scraper

    def self.parsed_url(zip_input)
        results = Geocoder.search("#{zip_input}")
        latitude = results.first.latitude
        longitude = results.first.longitude
        @url = "https://www.mobilize.us/?address=#{zip_input}&lat=#{latitude}&lon=#{longitude}&show_all_events=true"
    end

    def self.make_opportunities
        scrape_opportunities_page.css(".e1olnexu1").each do |event|
            Opportunity.new_from_page(event)
        end
    end

    def self.scrape_opportunities_page
        browser = Watir::Browser.new :chrome, headless: true
        browser.goto(@url)
        Nokogiri::HTML(browser.html)
    end



end