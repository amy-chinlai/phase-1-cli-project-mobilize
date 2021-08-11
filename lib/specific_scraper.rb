class SpecificScraper

    
    def scrape_specific_opportunities(link)
        browser = Watir::Browser.new :chrome, headless: true
        browser.goto("https://www.mobilize.us#{link}")
        doc = Nokogiri::HTML(browser.html)

        @about = doc.css("#collapseEventDetail-description").text
    end

    def add_about
        Opportunity.all.select do |event|
            event.about = @about
        end
    end

end