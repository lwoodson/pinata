# Pinata

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'pinata'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pinata

## Usage

```
> pinata
Lining up...
Whacking player.rb...
Whacking tennis-match.rb...
Looks like there is some candy!
remote -2 local 0
Your code improved!

> pinata -v
Lining up...
Whacking player.rb...
Whacking tennis-match.rb...
Looks like there is some candy!
remote -2 local 0
Your code improved!

WHACKER   FILE                   PREV   CURRENT
-----------------------------------------------
cane      player.rb               -1      1
cane      tennis-match.rb         -1      1
rubocop   player.rb                0     -1
rubocop   tennis-match.rb          0     -1
-----------------------------------------------
TOTAL                             -2      0

> pinata -r
Lining up...
Whacking player.rb...
Whacking tennis-match.rb...
Looks like there is some candy!
remote -2 local 0
Your code improved!

WHACKER   ISSUE
----------------------------------------------
rubocop   (2) Line ends with trailing whitespace

> pinata -vr
Lining up...
Whacking player.rb...
Whacking tennis-match.rb...
Looks like there is some candy!
remote -2 local 0
Your code improved!

WHACKER   ISSUE
----------------------------------------------
rubocop   (2) Line ends with trailing whitespace

WHACKER   FILE                   PREV   CURRENT
-----------------------------------------------
cane      player.rb               -1      1
cane      tennis-match.rb         -1      1
rubocop   player.rb                0     -1
rubocop   tennis-match.rb          0     -1
-----------------------------------------------
TOTAL                             -2      0

> pinata -d json
{date: '05291970', total: 0, cane: 2, rubocop: -2}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
