# Mobilize Event Finder
### Flatiron software engineering, phase 1 project

This Ruby project provides a CLI to find events on Mobilize (https://www.mobilize.us/), a volunteer recruitment and event management platform for Democrats. It searches for events by zip code, outputs the first 25 opportunities via scraping, and views details of individual opportunities.

The scraping is done in two parts when initializing a new instance of the `Scraper` class. First, the page listing the first 25 opportunities in the area is scraped. 

The first thing the CLI does is retrieve the zip code from the user. In the `Scraper` class, `#parsed_url` then takes that zip code and uses the `geocoder` gem to output latitude and longitude coordinates that are used in the `@url` that displays all events.

`#scrape_opportunities_page` uses the `nokogiri`, `watir`, and `webdrivers` gems to open `@url`. The `headless` gem is used to do this headlessly. `#make_opportunities` calls upon `#scrape_opportunities_page` and `.new_from_page` to initialize new instances of the `Opportunity` class. This populates each opportunity's name, date, location, and link.

The second scrape happens in `#scrape_specific_opportunities` and `#add_about`. These two methods work together to go to each opportunity's link and scrape the about section of the page. The about text is then added to the appropriate instance of `Opportunity`.


## Installation

    Go to https://github.com/amy-chinlai/phase-1-cli-project-mobilize and clone the repository to your local machine.
    Run `bundle install`.
    Run `brew install --cask chromedriver`. You will need Homebrew (https://brew.sh/) to do this.

## Usage

Type the below and follow the on screen prompts.

    $ ruby bin/mobilize_finder

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/amy-chinlai/phase-1-cli-project-mobilize. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).