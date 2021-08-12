class Scraper
    
    def initialize(zip_input)
        parsed_url(zip_input)
        make_opportunities
        add_about
    end
    
    # general scraper methods
    
    def parsed_url(zip_input)
        results = Geocoder.search("#{zip_input}")
        latitude = results.first.latitude
        longitude = results.first.longitude
        @url = "https://www.mobilize.us/?address=#{zip_input}&lat=#{latitude}&lon=#{longitude}&show_all_events=true"
    end

    def make_opportunities
        scrape_opportunities_page.css(".e1olnexu1").each do |event|
            Opportunity.new_from_page(event)
        end
    end

    def scrape_opportunities_page
        browser = Watir::Browser.new :chrome, headless: true
        browser.goto(@url)
        Nokogiri::HTML(browser.html)
    end

    # specific opportunity scraper methods

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