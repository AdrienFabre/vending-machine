class VendingMachine
  def initialize(items, interface = Interface.new)
    @items = items
    @interface = interface
  end

  def show_items
    @interface.print_items(@items)
    @items
  end

  def select_item(product, money)
    @items.each do |item|
      if item[:name] == product
        balance = money - item[:price]
        @interface.print_message(balance, item)
        return balance
      end
    end
  end
end
