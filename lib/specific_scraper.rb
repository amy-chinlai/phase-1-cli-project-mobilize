class SpecificScraper

    
    def self.scrape_specific_opportunities(link)
        browser = Watir::Browser.new
        puts "before browser.go_to".green
        browser.goto("https://www.mobilize.us#{link}")
        puts "after browser.goto".green
        doc = Nokogiri::HTML(browser.html)

        @about = doc.css("#collapseEventDetail-description").text
    end

    def self.add_about
        Opportunity.all.select do |event|
            event.about = @about
        end
    end

end