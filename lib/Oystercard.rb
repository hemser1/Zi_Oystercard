class Station

  attr_reader :name, :zone

  def initialize(name, zone)
    @name = name
    @zone = zone
  end

end

class Journey

  attr_accessor :exit_station

  def initialize(station)
    @entry_station = station
    @exit_station = nil
  end

  def record
    { "entry_station" => @entry_station, "exit_station" => @exit_station }
  end

  def fare

  end
end

#########################


class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1
  COST = MINIMUM_CHARGE

  attr_reader :balance, :entry_station

  def initialize(balance=0)
    @balance = balance
    @in_journey = false
    @entry_station = nil
    @history = []
  end

  def top_up(amount)
    raise "you don't want to lose that much money"  if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station = "default")
    raise "Minimum balance is 1£" if @balance < MINIMUM_CHARGE
    @entry_station = entry_station
    @in_journey = Journey.new(entry_station)
  end

  def touch_out(exit_station = "default")
    deduct(COST)
    @in_journey.exit_station = exit_station
    @history << @in_journey.record
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def print_history
    @history
  end
private
  def deduct(amount)
    @balance -= amount
  end

end


oc = Oystercard.new

oc.top_up(90)

oc.touch_in("Mile End")
oc.touch_out("Aldgate East")

p oc.print_history
