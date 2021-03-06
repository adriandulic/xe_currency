require "spec_helper"

describe Money::Bank::XeCurrency do
  it "converts rates" do
    stub_request(:get, "http://www.xe.com/currencyconverter/convert?Amount=1&From=JPY&To=USD").
      to_return(body: get_response("JPY_TO_USD.html"))
    stub_request(:get, "http://www.xe.com/currencyconverter/convert?Amount=1&From=USD&To=JPY").
      to_return(body: get_response("USD_TO_JPY.html"))

    money = Money.new(10_000, "JPY")
    expect(money.exchange_to(:USD).to_s).to eq("89.72")
  end
end
