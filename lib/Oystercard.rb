class Oystercard

MAXIMUM_BALANCE = 90

attr_reader :balance

  def initialize(balance=0)
    @balance = balance
  end

  def top_up(amount)
    raise "you don't want to loose that much money"  if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

end
