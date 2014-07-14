require "colcolor/version"

module Colcolor
  COLORS = %i(black red green yellow blue magenta cyan white clear).zip([*30..37, 0]).map { |k,v| [k, "\e[#{v}m"] }.to_h.freeze

  BGCOLORS = %i(bg_black bg_red bg_green bg_yellow bg_blue bg_magenta bg_cyan bg_white).zip(40..47).map { |k,v| [k, "\e[#{v}m"] }.to_h.freeze

  EXTRAS = %i(clear bold underline blink reverse).zip([0, 1, 4, 5, 7]).map { |k,v| [k, "\e[#{v}m"] }.to_h.freeze

  def c(*colors, regexp:/\S+/)
    cs = colors.dup
    self.gsub(regexp) do
      color = COLORS[cs.shift] || COLORS[:white]
      color + $& + COLORS[:clear]
    end
  end
end

String.send(:include, Colcolor)

