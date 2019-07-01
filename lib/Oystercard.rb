class Oystercard

MAXIMUM_BALANCE = 90
MINIMUM_CHARGE = 1
COST = MINIMUM_CHARGE

attr_reader :balance, :in_journey

  def initialize(balance=0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    raise "you don't want to loose that much money"  if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in
    raise "Minimum balance is 1£" if @balance < MINIMUM_CHARGE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(COST)
  end

  def in_journey?
    @in_journey
  end

private 
  def deduct(amount)
    @balance -= amount
  end


end
