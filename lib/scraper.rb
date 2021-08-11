class Scraper

    
    def get_page
        browser = Watir::Browser.new(:phantomjs)
        Nokogiri::HTML(browser.html)
        browser = Watir::Browser.new
        doc = Nokogiri::HTML(browser.html)
    end

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
        # @opportunities.map {|opportunity| Opportunity.new_from_page(opportunity[:name], opportunity[:date], opportunity[:location], opportunity[:link])}
    end

    def self.scrape_opportunities_page
        browser = Watir::Browser.new
        browser.goto(@url)
        # doc = Nokogiri::HTML(browser.html)
        Nokogiri::HTML(browser.html)
        

        # opportunities_list = []
        # doc.css(".e1olnexu1").each do |section|
        #     opportunities_list << section
        # end

        # @opportunities = []
        # opportunities_list.each do |opportunity|
        #     info_hash = Hash.new
        #     info_hash[:name] = opportunity.css(".css-1i6gh54").text
        #     info_hash[:date] = opportunity.css(".e1olnexu5").text
        #     info_hash[:location] = opportunity.css(".e1olnexu14").text
        #     info_hash[:link] = opportunity.attribute("href").value
        #     @opportunities << info_hash
        # end
        # @opportunities
    end



end