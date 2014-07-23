require "colcolor/version"

module Colcolor
  def self.TAGMAP(colors, codes)
    Hash[ colors.zip(codes).map { |k, v| [k, "\e[#{v}m"] } ].freeze
  end

  COLORSET = %i(black red green yellow blue magenta cyan white)
  COLORS = TAGMAP(COLORSET, 30..37)
  BGCOLORS = TAGMAP(COLORSET, 40..47)
  EXTRA = TAGMAP(%i(clear bold underline blink reverse), [0,1,4,5,7])

  def colco(*colors, regexp:/\S+/, cycle:false)
    cs = cycle ? colors.cycle : colors.to_enum
    self.gsub(regexp) do
      cname = cs.next rescue nil
      color = build_color_tag(cname)
      color.empty? ? $& : (color + $& + EXTRA[:clear])
    end
  end

  private
  def build_color_tag(name)
    if tag = COLORS[name] || EXTRA[name]
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
