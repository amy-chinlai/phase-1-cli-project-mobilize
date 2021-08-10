require 'watir'
require 'nokogiri'
require 'geocoder'

class Scraper

    attr_accessor :zip_input
    
    def get_page
        browser = Watir::Browser.new(:phantomjs)
        # browser.goto(parsed_url)
        Nokogiri::HTML(browser.html)
        browser = Watir::Browser.new
        doc = Nokogiri::HTML(browser.html)
    end

    def self.parsed_url(zip_input)
        results = Geocoder.search("#{zip_input}")
        result = 
        puts result
        latitude = results.first.latitude
        longitude = results.first.longitude
        @url = "https://www.mobilize.us/?address=#{zip_input}&lat=#{latitude}lon=#{longitude}&show_all_events=true"
        @url
    end

    def make_opportunities
        Scraper.scrape_opportunities_page.each {|opportunity| Opportunity.new_from_page(opportunity)}
    end



    def self.scrape_opportunities_page
        browser = Watir::Browser.new
        browser.goto(@url)
        doc = Nokogiri::HTML(browser.html)
        opportunities_list = doc.css(".e1olnexu8")
        @opportunites = []
        puts "opportunities_list below!"
        puts opportunities_list
        opportunities_list.each do |opportunity|
            info_hash = Hash.new
            info_hash[:name] = doc.css(".css-1i6gh54").text
            info_hash[:date] = doc.css(".e1olnexu5").text
            info_hash[:location] = doc.css(".e1olnexu14").text
            puts "info hash below!"
            puts info_hash
            @opportunities << info_hash
        end
        @opportunities
    end



end