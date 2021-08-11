require 'watir'

class SpecificScraper

    def specific_url(link)
        puts "before calling @specific_url"
        @specific_url = "https://www.mobilize.us#{link}"
        puts "after calling @specific_url"
    end
    
    def self.scrape_specific_opportunities
        browser = Watir::Browser.new
        browser.goto(@specific_url)
        doc = Nokogiri::HTML(browser.html)

        @about = doc.css("#collapseEventDetail-description").text
    end

    def self.add_about
        Opportunity.all.select do |event|
            event.about = @about
        end
    end

end