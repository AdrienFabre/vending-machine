class VendingMachine
  attr_accessor :items, :interface, :selection, :change
  attr_reader :convert_to_value
  def initialize(args)
    @items = args[:items]
    @interface = args[:interface] || Interface.new
    @change = args[:change]
    @selection = { name: nil, price: nil, balance: 0 }
    @convert_to_value = {
      '1p' => 0.01,
      '2p' => 0.02,
      '5p' => 0.05,
      '10p' => 0.1,
      '20p' => 0.2,
      '50p' => 0.5,
      '£1' => 1,
      '£2' => 2
    }
  end

  def show_items
    interface.print_items(items)
    items
  end

  def select_item(item_selected)
    selection[:balance] = 0
    update_selection(item_selected)
  end

  def insert_money(coin)
    update_change(coin)
    update_balance(convert_to_value[coin])
    interface.print_message(selection)
    validate_order if selection[:balance].positive?
    selection[:balance]
  end

  def add_change(new_change)
    new_change.each { |coin, quantity| change[coin] += quantity }
  end

  def add_items(name, quantity)
    items.each { |item| item[:quantity] += quantity if item[:name] == name }
  end

  private

  def update_selection(item_selected)
    items.each do |item|
      if item[:name] == item_selected
        selection[:name] = item[:name]
        selection[:price] = item[:price]
      end
    end
  end

  def update_change(coin)
    change[coin] += 1
  end

  def update_balance(money)
    if selection[:balance].zero?
      selection[:balance] = money - selection[:price]
    elsif selection[:balance].negative?
      selection[:balance] += money
    end
  end

  def validate_order
    calculate_change(selection[:balance])
    update_items(selection[:name])
  end

  def calculate_change(money_due)
    coins = %w[£2 £1 50p 20p 10p 5p 2p 1p]
    values = [2, 1, 0.5, 0.2, 0.1, 0.05, 0.02, 0.01]
    values.each_with_index do |value, index|
      while money_due >= value
        if money_due % value >= 0
          change[coins[index]] -= 1
          money_due -= value
        end
      end
    end
  end

  def update_items(item_name)
    items.each { |item| item[:quantity] -= 1 if item[:name] == item_name }
  end
end
