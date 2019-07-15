class VendingMachine
  attr_accessor :items

  def initialize(items)
    @items = items
  end

  def show_items
    items
  end
end
