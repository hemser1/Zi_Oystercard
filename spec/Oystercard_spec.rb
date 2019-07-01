require 'Oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  it "should have a balance" do
    expect(oystercard.balance).to eq(0)
  end
  it 'can top up the balance' do
    expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
    # change if rspec fails to one line
  end

  it "raises an error" do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    oystercard.top_up maximum_balance
    expect{oystercard.top_up(1)}.to raise_error "you don't want to loose that much money"
  end

  it "deducts money from the balance" do
    oystercard.top_up(20)
    expect{ oystercard.deduct 7 }.to change{ oystercard.balance }.by -7
  end

end
