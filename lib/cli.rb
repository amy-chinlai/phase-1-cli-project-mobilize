require 'geocoder'
require_relative '../lib/scraper'
require_relative '../lib/opportunity'

class CLI

    def print_opportunities
        Opportunity.all.each_with_index do |opportunity, index|
            puts "#{index}. #{opportunity.name}"
            puts "  - #{opportunity.date}"
            puts "  - #{opportunity.location}"
            puts "  - #{opportunity.link}"
        end
    end

    def print_details(specific_opportunity)
        puts "#{specific_opportunity.name}"
        puts "  - #{specific_opportunity.date}"
        puts "  - #{specific_opportunity.location}" 
        puts "  - #{specific_opportunity.about}" 
    end


    def begin_search
        puts "Hello, and welcome to the Mobilze search CLI!"
        puts "Let's find an event near you. What is your zip code?"

        zip_input = gets.strip
        Scraper.new
        Scraper.parsed_url(zip_input)
        puts "done parsing url!"
        Scraper.scrape_opportunities_page
        puts "done scraping opportunities page!"
        Scraper.make_opportunities
        puts "done making opportunities!"
        # Opportunity.new_from_page
        puts "Thanks!"


        # should I add in a fallback if it's an invalid zip? Or do a regex?
        print_opportunities

        puts "Which event would you like to see more details for?"
        details_input = gets.to_i - 1

        specific_opportunity = Opportunity.all[details_input]
        specific_link = specific_opportunity.link
        Scraper.specific_url(specific_link)
        Scraper.scrape_specific_opportunities
        Scraper.add_about

        puts "printing details soon!"
        print_details(specific_opportunity)

        puts "the details have been printed!"

        puts "Do you want to see the list of events again? Please enter Y or N."
        again_input = gets.strip.downcase

        if again_input == "y"
            begin_search
        elsif again_input == "n"
            puts "Cool! Hope you sign up to volunteer somewhere. Have a good day!"
        else
            puts "I didn't understand that answer. Let's start over, shall we?"
            begin_search
        end

    end



end