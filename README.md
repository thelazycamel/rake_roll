# RakeRoll

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'rake_roll'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rake_roll

## Usage

rake roll

rake roll                        # current version 0.1.0 and options
rake roll:bump:pre               # Bump to 0.1.0a
rake roll:bump                   # Bump to 0.1.1
rake roll:bump:major             # Bump to 1.0.0
rake roll:bump:minor             # Bump to 0.2.0

The above will do a dry run, and show the changelog updates in the
terminal window

run the command with push to update the version, changelog and push
everything up on the current branch of the git repo

i.e.
rake roll:bump PUSH=true

## Contributing

1. Fork it ( http://github.com/<my-github-username>/rake_roll/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
