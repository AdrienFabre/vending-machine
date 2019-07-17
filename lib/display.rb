class Display
  def print_items(items)
    items.each do |item|
      next if item[:quantity] < 1

      puts "#{item[:name]} #{convert_to_price(item[:price])}"
    end
  end

  def print_message(order)
    balance = order[:balance]
    if balance.zero?
      puts order[:name]
    elsif balance.negative?
      puts "#{convert_to_price(balance.abs)} is missing!"
    elsif balance.positive?
      puts "Here is your change: #{convert_to_price(balance)}"
    end
  end

  private

  def convert_to_price(value)
    format('£%2.2f', value)
  end
end
