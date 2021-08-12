class Opportunity

    attr_accessor :date, :name, :location, :about, :link

    @@all = []

    def initialize(name, date = "There is no specified time for this event!", location = "There's no location for this event!", link)
        @name = name
        @location = location
        @date = date
        @link = link
        @about = about
        @@all << self
    end

    def self.new_from_page(event)
        self.new(event.css(".css-1i6gh54").text, event.css(".e1olnexu5").text, event.css(".e1olnexu14").text, event.attribute("href").value)
        # .css-1i6gh54 is name
        # .e1olnexu5 is date
        # .e1olnexu14 is address

    end

    def self.all
        @@all
    end   

end