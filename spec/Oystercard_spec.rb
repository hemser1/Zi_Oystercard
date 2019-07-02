require 'Oystercard'

describe Station do
  subject {described_class.new("Aldgate",1)}
  it "should return name" do
    expect(subject.name).to eq "Aldgate"
  end
  it "should return zone" do
    expect(subject.zone).to eq 1
  end

end

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:entry_station) { double :entry_station }
  let (:exit_station) { double :exit_station }
  maximum_balance = Oystercard::MAXIMUM_BALANCE
  minimum_balance = Oystercard::MINIMUM_CHARGE

  it "should have a balance" do
    expect(oystercard.balance).to eq(0)
  end
  it 'can top up the balance' do
    expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
  # change if rspec fails to one line
  end



  it "raises and error" do
    oystercard.top_up minimum_balance-0.1
    expect{oystercard.touch_in}.to raise_error "Minimum balance is 1£"
  end

  it "has no journeys in history by default" do
    expect(oystercard.print_history.length).to eq 0
  end



  # it "deducts money from the balance" do
  #   oystercard.top_up(20)
  #   expect{ oystercard.deduct 7 }.to change{ oystercard.balance }.by -7
  # end


  context "when topped up" do
    before do
      oystercard.top_up maximum_balance
    end

    it "raises an error" do
      expect{oystercard.top_up(1)}.to raise_error "you don't want to lose that much money"
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

    it "deducts money" do
      oystercard.touch_in
      cost = Oystercard::COST
      expect{ oystercard.touch_out}.to change{ oystercard.balance }.by -cost
    end

    it "will remember the touch in entry_station" do
      oystercard.touch_in(entry_station)
      expect(oystercard.entry_station).to eq entry_station
    end

  end

  context "when a journey has been completed" do
    let(:journey) { {
      "entry_station" => entry_station,
      "exit_station" => exit_station
      } }
    before do
      oystercard.top_up maximum_balance
    end
    it "will print out your journey history" do
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.print_history).to include journey
    end
  end
end
