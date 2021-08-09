class Scraper

    def get_page
        Nokogiri::HTML(open("https://www.mobilize.us/?show_all_events=true"))
    end

    def opportunities_list
        self.get_page.css(".css-19fddw")
    end

    def make_opportunities
        opportunities_list.each {|opportunity| Opportunity.new_from_page(opportunity)}
    end


end