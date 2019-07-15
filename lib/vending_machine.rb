class VendingMachine
  attr_accessor :items, :interface, :balance, :selection

  def initialize(items, interface = Interface.new)
    @items = items
    @interface = interface
    @selection = { name: nil, price: nil, balance: 0 }
    @balance = 0
  end

  def show_items
    interface.print_items(@items)
    items
  end

  def select_item(item_selected)
    selection[:balance] = 0
    items.each do |item|
      if item[:name] == item_selected
        selection[:name] = item[:name]
        selection[:price] = item[:price]
      end
    end
  end

  def insert_money(money)
    update_balance(money)
    interface.print_message(selection)
    selection[:balance]
  end

  private

  def update_balance(money)
    if selection[:balance] == 0
      selection[:balance] = money - selection[:price]
    elsif selection[:balance] < 0
      selection[:balance] += money
    end
  end
end
