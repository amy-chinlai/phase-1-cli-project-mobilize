class Opportunity

    attr_accessor :date, :name, :location, :about, :latitude, :longitude, :link

    @@all = []

    def initialize(name = nil, date = "There is no specified time for this event!", location = "There's no location for this event!", about = "There's no additional information here!", link)
        @name = name
        @location = location
        @date = date
        @link = link
        @about = about
        @@all << self
    end

    def self.new_from_page(name, date, location, link)
        self.new(name, date, location, link)
    end

    def self.all
        @@all
    end

    def add_about_from_page(about)
        @about = about
    end

   

end