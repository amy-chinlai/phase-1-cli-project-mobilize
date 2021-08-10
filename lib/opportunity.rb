require 'geocoder'

class Opportunity
    # extend Geocoder::Model::ActiveRecord

    attr_accessor :date, :name, :location, :about, :latitude, :longitude

    @@all = []

    def initialize(name = nil, date = "There is no specified time for this event!", location = "There's no location for this event!", about = "There's no additional information here!")
        @name = name
        @location = location
        @date = date
        @about = about
    end

    def self.new_from_page(opportunity)
        Opportunity.new(name, date, location)
    end

    def self.all
        @@all
    end

    # def self.parsed_url(zip_input)
    #     coordinates = Geocoder.search(zip_input).first.coordinates
    #     latitude = coordinates[0]
    #     longitude = coordinates[1]
    #     url = "https://www.mobilize.us/?address=#{zip_input}&lat=#{latitude}lon=#{longitude}&show_all_events=true"
    #     url
    # end

    # def self.doc(parsed_url)
    #     Nokogiri::HTML(open(parsed_url))
    # end

    # def name
    #     @name || doc.css(".css-1i6gh54")
    # end

    # def date
    #     @date || doc.css(".e1olnexu5")
    # end

    # def location
    #     @location || doc.css(".e1olnexu14")
    # end




end