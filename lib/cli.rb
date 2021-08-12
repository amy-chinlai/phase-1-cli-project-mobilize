class CLI

    def valid_zip?(zip_input)
       true if zip_input.to_s =~ /^[0-9]{5}?$/  
    end

    def valid_entry?(details_input)
        true if details_input.to_s =~ /^[0-9]{1,2}?$/  
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
        puts "Hello, and welcome to the Mobilze search CLI!".green
        begin_search
    end

    def begin_search
        puts "Let's find an event near you. What is your five-digit zip code?".green

        zip_input = gets.strip
        if !valid_zip?(zip_input)
            puts "Hmm, looks like that zip code is invalid.".red
            begin_search
        else
            puts "Thanks!".green
            @scraper = Scraper.new(zip_input)
            begin_details
        end
    end

    def begin_details
        puts "Here are opportunities near you:".green

        print_opportunities

        puts "Which event would you like to see more details for? Please enter the number to the left of the event's name.".green
        details_input = gets.to_i - 1
        if !valid_entry?(details_input)
            puts "Hmm, I don't understand. Please try again".red
            begin_details
        else
            specific_opportunity = Opportunity.all[details_input]
            specific_link = specific_opportunity.link
            @scraper.scrape_specific_opportunities(specific_link)
            @scraper.add_about

            print_details(specific_opportunity)
            begin_close
        end
    end

    def begin_close

        puts "Do you want to see the list of events again? Please enter Y or N.".green
        puts "You can also enter 'search again' to see additional events for another zip code.".green
        again_input = gets.strip.downcase

        if again_input == "y"
            begin_details
        elsif again_input == "n"
            puts "Cool! Hope you sign up to volunteer somewhere. Have a good day!".green
        elsif again_input == "search again"
            begin_search
        else
            puts "I didn't understand that answer. Let's start over, shall we?".red
            begin_search
        end

    end



end