# Findrr [![Build Status](https://secure.travis-ci.org/myokoym/findrr.png?branch=master)](http://travis-ci.org/myokoym/findrr)

A search tool for filenames in your directories.

## Requirements

* [Rroonga](http://ranguba.org/)
* [Thor](http://whatisthor.com/)

## Installation

Add this line to your application's Gemfile:

    gem "findrr"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install findrr

## Usage

### Collect filenames (take a few minutes)

    $ findrr collect PATH

### Search for filenames in the collection

    $ findrr search PART_OF_FILENAME

## License

Copyright (c) 2013 Masafumi Yokoyama

LGPLv3 or later.

See 'license/lgpl-3.0.txt' or 'http://www.gnu.org/licenses/lgpl-3.0' for details.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
