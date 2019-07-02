class Station

  attr_reader :name, :zone

  def initialize(name, zone)
    @name = name
    @zone = zone
  end

end

class Journey

  MINIMUM_CHARGE = 1
  PENALTY_CHARGE = 6
  attr_accessor :exit_station


  def initialize(entry_station, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def record
    { "entry_station" => @entry_station, "exit_station" => @exit_station }
  end

  def fare
    @entry_station.nil? ? PENALTY_CHARGE : MINIMUM_CHARGE
  end

end

#########################


class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance

  def initialize(balance=0)
    @balance = balance
    @in_journey = false
    @history = []
  end

  def top_up(amount)
    raise "you don't want to lose that much money"  if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station = "default")
    charge_penatly if @in_journey != false
    raise "Minimum balance is 1£" if @balance < Journey::MINIMUM_CHARGE
    @in_journey = Journey.new(entry_station)
  end

  def touch_out(exit_station = "default")
    @in_journey = Journey.new(nil) if @in_journey == false
    deduct(@in_journey.fare)
    @in_journey.exit_station = exit_station
    add_history
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

  def add_history
    @history << @in_journey.record
    @in_journey = false
  end

  def charge_penatly
      deduct(Journey::PENALTY_CHARGE)
      add_history
  end
end
