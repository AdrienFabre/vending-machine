class VendingMachine
  attr_accessor :items, :display, :order, :change, :dispenser, :sales_history
  attr_reader :change_converter
  def initialize(args)
    @items = args[:items]
    @change = args[:change]
    @display = args[:display] || Display.new
    @dispenser = args[:dispenser] || Dispenser.new
    @change_converter = args[:change_converter]
    @order = { name: nil, price: nil, balance: 0 }
    @sales_history = []
  end

  def show_items
    display.print_items(items)
    items
  end

  def select_item(item_selected)
    if order[:balance] != 0
      order[:balance] = order[:balance].abs
      display.print_message(order)
      dispense_change(order[:balance])
      order[:balance] = 0
    end
    update_order(item_selected)
  end

  def insert_money(coin)
    update_change(coin)
    update_balance(coin)
    display.print_message(order)
    dispense_order if order[:balance] >= 0
    order[:balance]
  end

  def add_change(new_change)
    new_change.each { |coin, quantity| change[coin] += quantity }
  end

  def add_items(name, quantity)
    items.each { |item| item[:quantity] += quantity if item[:name] == name }
  end

  def sales_report
    display.print_report(sales_history)
    sales_history
  end

  private

  def update_order(item_selected)
    items.each do |item|
      if item[:name] == item_selected
        order[:name] = item_selected
        order[:price] = item[:price]
      end
    end
  end

  def update_change(coin)
    change[coin] += 1
  end

  def update_balance(coin)
    value = change_converter[coin]
    if order[:balance].zero?
      order[:balance] = value - order[:price]
    else
      order[:balance] += value
    end
  end

  def dispense_order
    dispense_change(order[:balance]) if order[:balance].positive?
    dispenser.dispense_item(order[:name])
    update_items(order[:name])
    record_sale
  end

  def record_sale
    old_sale =
      sales_history.detect { |old_sales| old_sales[:name] == order[:name] }

    if old_sale
      old_sale[:sales] += 1
    else
      sales = Hash.new(0)
      sales[:name] = order[:name]
      sales[:sales] += 1
      sales_history << sales
    end
  end

  def dispense_change(money_due)
    coins = change_converter.keys.reverse
    values = change_converter.values.reverse
    values.each_with_index do |value, index|
      while money_due >= value
        next if (money_due % value).negative?

        change[coins[index]] -= 1
        dispenser.dispense_change(change[coins[index]])
        money_due -= value
      end
    end
  end

  def update_items(item_name)
    items.each { |item| item[:quantity] -= 1 if item[:name] == item_name }
  end
end
