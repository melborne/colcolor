require 'spec_helper'

describe Colcolor do
  it 'has a version number' do
    expect(Colcolor::VERSION).not_to be nil
  end

  describe "String#c" do
    before do
      @str = "George 18 guitarist"
    end

    context "match words and colors sizes" do
      it "colors each words with given colors" do
        expect = "\e[32mGeorge\e[0m \e[33m18\e[0m \e[31mguitarist\e[0m"
        color_set = [:green, :yellow, :red]
        expect(@str.colco(*color_set)).to eq expect
      end

      it "colors background of words" do
        expect = "\e[42mGeorge\e[0m \e[43m18\e[0m \e[41mguitarist\e[0m"
        color_set = [:bg_green, :bg_yellow, :bg_red]
        expect(@str.colco(*color_set)).to eq expect
      end
    end

    context "two or more color attributes to a word" do
      it "colors a word with two attrs" do
        str = "Charlie is great!"
        expect = "\e[32mCharlie\e[0m is \e[31m\e[4mgreat!\e[0m"
        color_set = [:green, nil, :red_underline]
        expect(str.colco(*color_set)).to eq expect
      end

      it "colors a word with three attrs" do
        str = "Charlie is great!"
        expect = "\e[32mCharlie\e[0m is \e[31m\e[43m\e[4mgreat!\e[0m"
        color_set = [:green, nil, :red_yellow_underline]
        expect(str.colco(*color_set)).to eq expect
      end

      it "colors a word with color attrs but no foreground" do
        str = "Charlie is great!"
        expect = "\e[32mCharlie\e[0m is \e[43m\e[4mgreat!\e[0m"
        color_set = [:green, nil, :_yellow_underline]
        expect(str.colco(*color_set)).to eq expect
      end
    end

    context "short colors" do
      it "colors a word white for missing color" do
        expect = "\e[32mGeorge\e[0m \e[33m18\e[0m guitarist"
        color_set = [:green, :yellow]
        expect(@str.colco(*color_set)).to eq expect
      end

      it "colors a word white at intermidiate" do
        expect = "\e[32mGeorge\e[0m 18 \e[31mguitarist\e[0m"
        color_set = [:green, nil, :red]
        expect(@str.colco(*color_set)).to eq expect
      end
    end

    context "irregular pattern" do
      it "gets regexp to define the chunks" do
        str = "George + 18 guitarist"
        expect = "\e[32mGeorge\e[0m \e[33m+ 18\e[0m \e[31mguitarist\e[0m"
        color_set = [:green, :yellow, :red]
        re = /\+\s*\d+|\S+/
        expect(str.colco(*color_set, regexp:re)).to eq expect
      end
    end

    context "with cycle option" do
      it "applys colors cyclic to the text" do
        str = "a b c d e f"
        expect = "\e[31ma\e[0m \e[32mb\e[0m \e[33mc\e[0m \e[31md\e[0m \e[32me\e[0m \e[33mf\e[0m"
        color_set = [:red, :green, :yellow]
        expect(str.colco(*color_set, cycle:true)).to eq expect
      end
    end
  end
end
