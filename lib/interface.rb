class Interface
  def print_items(items)
    items.each do |item|
      puts "#{item[:name]} #{convert_to_price(item[:price])}"
    end
  end

  def print_message(balance, item)
    case
    when balance == 0
      puts item[:name]
    when balance.negative?
      puts "#{convert_to_price(balance.abs)} is missing!"
    when balance.positive?
      puts "Here is your change: #{convert_to_price(balance)}"
    end
  end

  private

  def convert_to_price(value)
    sprintf('£%2.2f', value)
  end
end
