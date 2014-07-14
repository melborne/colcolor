require 'spec_helper'

describe Colcolor do
  it 'has a version number' do
    expect(Colcolor::VERSION).not_to be nil
  end

  describe "String#c" do
    context "match words and colors sizes" do
      it "colors each words with given colors" do
        str = "George 18 guitarist"
        expect = "\e[32mGeorge\e[0m \e[33m18\e[0m \e[31mguitarist\e[0m"
        color_set = [:green, :yellow, :red]
        expect(str.c(*color_set)).to eq expect
      end
    end

    context "short colors" do
      it "colors a word white for missing color" do
        str = "George 18 guitarist"
        expect = "\e[32mGeorge\e[0m \e[33m18\e[0m \e[37mguitarist\e[0m"
        color_set = [:green, :yellow]
        expect(str.c(*color_set)).to eq expect
      end

      it "colors a word white at intermidiate" do
        str = "George 18 guitarist"
        expect = "\e[32mGeorge\e[0m \e[37m18\e[0m \e[31mguitarist\e[0m"
        color_set = [:green, nil, :red]
        expect(str.c(*color_set)).to eq expect
      end
    end
  end
end
