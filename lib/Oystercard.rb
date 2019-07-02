class Station

end

class Oystercard

MAXIMUM_BALANCE = 90
MINIMUM_CHARGE = 1
COST = MINIMUM_CHARGE

attr_reader :balance, :entry_station

  def initialize(balance=0)
    @balance = balance
    @in_journey = false
    @entry_station = nil
  end

  def top_up(amount)
    raise "you don't want to lose that much money"  if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station = "default")
    raise "Minimum balance is 1£" if @balance < MINIMUM_CHARGE
    @in_journey = true
    @entry_station = station
  end

  def touch_out
    @in_journey = false
    @entry_station = nil
    deduct(COST)
  end

  def in_journey?
    @entry_station
    #same as !!@entry_station
  end

private
  def deduct(amount)
    @balance -= amount
  end


end
