# Colcolor

Easily colorize terminal text by each column.

## Installation

Add this line to your application's Gemfile:

    gem 'colcolor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install colcolor

## Usage

You want to colorize terminal outputs in which each column have different color.

It can be easily achieved with `String#colco` method as follows:

```ruby
require "colcolor"

list = <<-EOS
Charlie\t21\tprogrammer
Bill\t43\tdoctor
Liz\t18\tstudent
EOS

list.each_line do |line|
  puts line.colco(:green, :yellow, :blue)
end
```

Output:

![sample1](https://github.com/melborne/colcolor/raw/screenshot/sample1.png)

If you want to have background colors or some decorations onto them, chain the names with underscores:

```ruby
list.each_line do |line|
  puts line.colco(:green, :red_yellow, :blue_underline)
end
```

Output:

![sample2](https://github.com/melborne/colcolor/raw/screenshot/sample2.png)

If you prefer ages(second column) without color, pass `nil` for it:

```ruby
list.each_line do |line|
  puts line.colco(:green, nil, :blue_underline)
end
```

Output:

![sample3](https://github.com/melborne/colcolor/raw/screenshot/sample3.png)

You have full names in the list and want to apply bgcolor for them, `regexp` option might helps you.

```ruby
list = <<-EOS
Charlie Brown\t21\tprogrammer
Bill Clinton\t43\tdoctor
Liz Taylor\t18\tstudent
EOS

# less appropriate example:

list.each_line do |line|
  puts line.colco(:bg_green, :bg_green, :yellow, :blue_underline)
end

puts

# example with regexp option:

re = /^.*?(?=\t)|\S+/ # match any characters before the first tab or non whitespaces

list.each_line do |line|
  puts line.colco(:bg_green, :yellow, :blue_underline, regexp:re)
end
```

Output:

![sample4](https://github.com/melborne/colcolor/raw/screenshot/sample4.png)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/colcolor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
