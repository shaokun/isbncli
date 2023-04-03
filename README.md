# ISBN Validator CLI

A command-line interface (CLI) for validating ISBNs using the `Isbncli::IsbnValidator` class.

## Setup

1. Install Ruby 2.6 or higher if it is not already installed.
2. Clone this repository to your local machine.
3. Navigate to the project directory and run `bundle install` to install the required gems.

## Usage

To validate an ISBN, run the following command:

```bash
./bin/cli <isbn>
./bin/cli 9780143007235
```

Where `<isbn>` is the ISBN you want to validate. The output will be colored green if the ISBN is valid, and red if it is invalid.

## Testing

To run the RSpec tests, navigate to the project directory and run `rspec spec`. The tests should all pass.
