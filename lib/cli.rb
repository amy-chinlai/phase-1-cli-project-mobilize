require 'geocoder'
require 'colorize'
require_relative '../lib/scraper'
require_relative '../lib/opportunity'
require_relative '../lib/specific_scraper'

class CLI

    def valid_zip?(zip_input)
        return true if zip_input.to_s =~ /^[0-9]{5}?$/
    end
    
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


    def welcome
        puts "Hello, and welcome to the Mobilze search CLI!"
        begin_search
    end

    def begin_search
        puts "Let's find an event near you. What is your zip code?"

        zip_input = gets.strip
        if !valid_zip?(zip_input)
            puts "Hmm, looks like that zip code is invalid."
            begin_search
        else
            Scraper.new
            Scraper.parsed_url(zip_input)
            puts "done parsing url!".green
            Scraper.scrape_opportunities_page
            puts "done scraping opportunities page!".green
            Scraper.make_opportunities
            puts "done making opportunities!".green
            # Opportunity.new_from_page
            puts "Thanks!"
            begin_details
        end
    end

    def begin_details
        print_opportunities

        puts "Which event would you like to see more details for?"
        details_input = gets.to_i - 1

        specific_opportunity = Opportunity.all[details_input]
        specific_link = specific_opportunity.link
        puts specific_link
        # SpecificScraper.new.specific_url(specific_link)
        # puts "done generating @specific_url".green
        SpecificScraper.scrape_specific_opportunities(specific_link)
        SpecificScraper.add_about

        puts "printing details soon!".green
        print_details(specific_opportunity)

        puts "the details have been printed!".green

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