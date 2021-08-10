require 'watir'
require 'nokogiri'

class Scraper
    
    def get_page
        browser = Watir::Browser.new(:phantomjs)
        # browser.goto(parsed_url)
        Nokogiri::HTML(browser.html)
        browser = Watir::Browser.new
        doc = Nokogiri::HTML(browser.html)
    end

    def self.parsed_url(zip_input)
        coordinates = Geocoder.search(zip_input).first.coordinates
        latitude = coordinates[0]
        longitude = coordinates[1]
        @url = "https://www.mobilize.us/?address=#{zip_input}&lat=#{latitude}lon=#{longitude}&show_all_events=true"
        @url
    end

    def make_opportunities
        Scraper.scrape_opportunities_page.each {|opportunity| Opportunity.new_from_page(opportunity)}
    end



    def self.scrape_opportunities_page
        browser = Watir::Browser.new
        browser.goto(parsed_url(@url))
        Nokogiri::HTML(browser.html)
        browser = Watir::Browser.new
        doc = Nokogiri::HTML(browser.html)
        opportunities_list = doc.css(".css-9lofrv")
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