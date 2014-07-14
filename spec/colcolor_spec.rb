require 'spec_helper'

describe Colcolor do
  it 'has a version number' do
    expect(Colcolor::VERSION).not_to be nil
  end

  context "String#c" do
    it "returns a colored string" do
      str = "George 18 guitarist"
      expect = "\e[32mGeorge\e[0m \e[33m18\e[0m \e[31mguitarist\e[0m"
      color_set = [:green, :yellow, :red]
      expect(str.c(*color_set)).to eq expect
    end
  end
end
