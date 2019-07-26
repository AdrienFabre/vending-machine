require 'display'

describe Display do
  items = [
    { name: 'Orange Juice', price: 2, quantity: 3 },
    { name: 'Green Smoothie', price: 3, quantity: 5 },
    { name: 'Chocolate Bar', price: 4, quantity: 7 }
  ]

  subject(:display) { described_class.new }

  context 'in sleep mode' do
    it 'displays the list of items' do
      expect { display.print_items(items) }.to output(
        "Orange Juice £2.00\nGreen Smoothie £3.00\nChocolate Bar £4.00\n"
      )
        .to_stdout
    end
  end

  context 'receive a balance = 0' do
    it 'displays the selected item' do
      item = items[0]
      items[0][:balance] = 0
      expect { display.print_message(item) }.to output("Orange Juice\n")
        .to_stdout
    end
  end

  context 'receive not enough money' do
    it 'displays the missing money message' do
      item = items[0]
      items[0][:balance] = -1
      expect { display.print_message(item) }.to output("£1.00 is missing!\n")
        .to_stdout
    end
  end

  context 'receive too much money' do
    it 'displays here is your change message' do
      item = items[0]
      items[0][:balance] = 1
      expect { display.print_message(item) }.to output(
        "Here is your change: £1.00\n"
      )
        .to_stdout
    end
  end

  context 'is asked to print report' do
    items_report = [
      { name: 'Orange Juice', sales: 2 },
      { name: 'Chocolate Bar', sales: 2 },
      { name: 'Banana', sales: 1 }
    ]

    it 'displays the report' do
      expect { display.print_report(items_report) }.to output(
        "Orange Juice, Chocolate Bar, Banana\n"
      )
        .to_stdout
    end
  end
end
