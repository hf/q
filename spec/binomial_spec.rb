require 'q/scope'
require 'q/parser'

describe "Binomial" do
  before do
    @scope = Q::Scope.new
  end

  it "should be a number" do
    expect(eval "3378;").to eq 3378
    expect(eval "-3378;").to eq -3378
    expect(eval "18.;").to eq 18.0
    expect(eval "-18.;").to eq -18.0
    expect(eval "18.789;").to eq 18.789
    expect(eval "-18.232;").to eq -18.232
  end

  it "should do addition" do
    expect(eval "30 + 21;").to eq 30 + 21
    expect(eval "30 + -21;").to eq 30 + (-21)

    @scope['a'] = 15
    @scope['b'] = 30

    expect(eval "a + b;").to eq @scope['a'] + @scope['b']
  end

  it "should do subtraction" do
    expect(eval "30 - 15;").to eq 30 - 15
    expect(eval "-10 - 15;").to eq -10 - 15

    @scope['a'] = -15
    @scope['b'] = 80

    expect(eval "a - b;").to eq @scope['a'] - @scope['b']
  end

  def eval input
    if not input.end_with? ";"
      input = input + ";"
    end

    QParser.new.parse(input).eval(@scope)
  end
end
