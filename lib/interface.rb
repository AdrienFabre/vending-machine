class Interface
  def print_items(items)
    items.each do |item|
      puts "#{item[:name]} #{convert_to_price(item[:price])}"
    end
  end

  def print_message(item)
    balance = item[:balance]
    if balance.zero?
      puts item[:name]
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
