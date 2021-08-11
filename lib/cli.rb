class CLI

    def valid_zip?(zip_input)
       true if zip_input.to_s =~ /^[0-9]{5}?$/  
    end
    
    def print_opportunities
        Opportunity.all.each_with_index do |opportunity, index|
            puts "#{index + 1}. #{opportunity.name}".blue
            puts "  - #{opportunity.date}"
            puts "  - #{opportunity.location}"
        end
    end

    def print_details(specific_opportunity)
        puts "#{specific_opportunity.name}".blue
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
            puts "Hmm, looks like that zip code is invalid.".red
            begin_search
        else
            @scraper = Scraper.new
            puts "Thanks!"
            @scraper.parsed_url(zip_input)
            @scraper.scrape_opportunities_page
            @scraper.make_opportunities
            begin_details
        end
    end

    def begin_details
        puts "Here are opportunities near you:"

        print_opportunities

        puts "Which event would you like to see more details for?"
        details_input = gets.to_i - 1

        specific_opportunity = Opportunity.all[details_input]
        specific_link = specific_opportunity.link
        @scraper.scrape_specific_opportunities(specific_link)
        @scraper.add_about

        print_details(specific_opportunity)

        puts "Do you want to see the list of events again? Please enter Y or N."
        again_input = gets.strip.downcase

        if again_input == "y"
            begin_details
        elsif again_input == "n"
            puts "Cool! Hope you sign up to volunteer somewhere. Have a good day!"
        else
            puts "I didn't understand that answer. Let's start over, shall we?".red
            begin_search
        end

    end



end