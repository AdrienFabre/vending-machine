class Selection
  attr_reader :name, :price, :balance
  def initialize(name, price, balance = 0)
    @name = name
    @price = price
    @balance = balance
  end
end
