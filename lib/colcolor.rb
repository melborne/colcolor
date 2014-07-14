require "colcolor/version"

module Colcolor
  COLORS = Hash[
    %i( black red green yellow blue magenta cyan white )
      .zip(30..37)
      .map { |k,v| [k, "\e[#{v}m"] }
    ].freeze

  BGCOLORS = Hash[
    %i( black red green yellow blue magenta cyan white )
      .zip(40..47)
      .map { |k,v| [k, "\e[#{v}m"] }
    ].freeze

  EXTRA = Hash[
    %i( clear bold underline blink reverse )
      .zip([0, 1, 4, 5, 7])
      .map { |k,v| [k, "\e[#{v}m"] }
    ].freeze

  def colco(*colors, regexp:/\S+/)
    cs = colors.dup
    self.gsub(regexp) do
      color = build_color_tag(cs.shift)
      color + $& + EXTRA[:clear]
    end
  end

  private
  def build_color_tag(name)
    if tag = COLORS[name] || BGCOLORS["bg_#{name}".intern] || EXTRA[name]
      tag
    else
      fore, *ext = name.to_s.split('_').map(&:intern)
      tag = "#{COLORS[fore]}"
      ext = ext.inject("") { |t, ex|
              ex = BGCOLORS[ex] || EXTRA[ex]; "#{t}#{ex}" }
      tag << ext
    end
  end
end

String.send(:include, Colcolor)
