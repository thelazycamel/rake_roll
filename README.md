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

  rake roll                        # shows version and all options
  rake roll:pre                    # Bump to 0.1.0a
  rake roll:bump                   # Bump to 0.1.1
  rake roll:major                  # Bump to 1.0.0
  rake roll:minor                  # Bump to 0.2.0

  The above will do a dry run, and show the changelog updates in the
  terminal window

  ROLLING OUT FOR REAL

    To Roll out the command for real, (update the version, changelog and
    push everything up on the current branch of the git repo) use:

    rake roll:bump PUSH=true

  INITIAL SETUP

    Create a VERSION file with the tag 0.0.1 (and git tag 0.0.1) if a
    version file does not already exist, it will then create CHANGELOG
    file if one does not already exist, use:

    rake roll:build

  CHANGELOG

    Only commits starting with * will be added to the changelog, example:

    * BugFix: #1234 IE6 Positioning fix
    * Feature: #1111 Adding rake_roll to the Gemfile
    * HotFix: Don't Delete current users

  TODO

    Write tests
    Write RDocs
    Code Tidy

## Contributing

1. Fork it ( http://github.com/<my-github-username>/rake_roll/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
