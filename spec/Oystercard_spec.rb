require 'Oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  it "should have a balance" do
    expect(oystercard.balance).to eq(0)
  end
end
