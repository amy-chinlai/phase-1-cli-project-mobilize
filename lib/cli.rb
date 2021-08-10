require 'geocoder'
require_relative '../lib/scraper'
require_relative '../lib/opportunity'

class CLI

    def print_opportunities

    end


    # def begin_search
        puts "Hello, and welcome to the Mobilze search CLI!"
        puts "Let's find an event near you. What is your zip code?"

        zip_input = gets.strip
        Scraper.parsed_url(zip_input)
        Scraper.scrape_opportunities_page
        Scraper.new.make_opportunities
        # Opportunity.new_from_page

        puts "Thanks!"


        # should I add in a fallback if it's an invalid zip? Or do a regex?
        print_opportunities

        puts "Which event would you like to see more details for?"
        details_input = gets.to_i

        print_details(opportunity)

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

    # end

    # begin_search


end