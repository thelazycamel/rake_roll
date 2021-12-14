# RakeRoll

  RakeRoll: Roll out your release versions with ease, RakeRoll will version and tag a release then create an updated changelog of the git commits, picking only those starting with a *

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
    rake roll:revision               # Bump to 0.1.1
    rake roll:major                  # Bump to 1.0.0
    rake roll:minor                  # Bump to 0.2.0
    rake roll:bump                   # pass VERSION=*.*.* to create manual version number
    rake roll:next                   # run and update changelog without creating a tag

  The above will do a dry run, and show the changelog updates in the
  terminal window

  ROLLING OUT FOR REAL

    To Roll out the command for real, (update the version, changelog and
    push everything up on the current branch of the git repo) use:

    rake roll:bump PUSH=true

  CHANGELOG

    Only commits starting with *, 'Tech' or matching regex /^@[0-9a-zA-Z\-_]{3,27} #[0-9]{4,6} .{5,}/ will be added to the changelog, example:

    * BugFix: #1234 IE6 Positioning fix
    * Feature: #1111 Adding rake_roll to the Gemfile
    * HotFix: Don't Delete current users

    or

    @assembla-space #1234 Assembla style ticket heading
    @assembla-space #2345 Put what you want here
    @assembla-space #4567 Some title
    space-4567: Some Message

  FILES

    rake roll will create a VERSION and CHANGELOG file on the root of
    your project if they do not already exist.

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
