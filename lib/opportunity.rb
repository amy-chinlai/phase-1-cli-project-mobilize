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

    def self.new_from_page(event)
        self.new(event.css(".css-1i6gh54").text, event.css(".e1olnexu5").text, event.css(".e1olnexu14").text, event.attribute("href").value)
    end

    def self.all
        @@all
    end

    def add_about_from_page(about)
        @about = about
    end

   

end