require 'Oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station) { double :station}
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

  it "raises and error" do
    minimum_balance = Oystercard::MINIMUM_CHARGE
    oystercard.top_up minimum_balance-0.1
    expect{oystercard.touch_in}.to raise_error "Minimum balance is 1£"
  end



  # it "deducts money from the balance" do
  #   oystercard.top_up(20)
  #   expect{ oystercard.deduct 7 }.to change{ oystercard.balance }.by -7
  # end

  context "when topped up" do
    before do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up maximum_balance
    end

    it "can touch in" do
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end

    it "can touch out" do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

    it "deduces money" do
      cost = Oystercard::COST
      expect{ oystercard.touch_out}.to change{ oystercard.balance }.by -cost
    end

    it "will remember the touch in station" do
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end

  end
end
