require 'interface'

describe Interface do
  items = [
    { name: 'Orange Juice', price: 2 },
    { name: 'Green Smoothie', price: 3 }
  ]

  subject(:interface) { described_class.new }

  context 'in sleep mode' do
    it 'displays the list of items' do
      expect { interface.print_items(items) }.to output(
        'Orange Juice £2.00
Green Smoothie £3.00
'
      )
        .to_stdout
    end
  end

  context 'receive a balance = 0' do
    it 'displays the selected item' do
      item = items[0]
      items[0][:balance] = 0
      expect { interface.print_message(item) }.to output('Orange Juice
')
        .to_stdout
    end
  end

  context 'receive not enough money' do
    it 'displays the missing money message' do
      item = items[0]
      items[0][:balance] = -1
      expect { interface.print_message(item) }.to output('£1.00 is missing!
')
        .to_stdout
    end
  end

  context 'receive too much money' do
    it 'displays here is your change message' do
      item = items[0]
      items[0][:balance] = 1
      expect { interface.print_message(item) }.to output(
        'Here is your change: £1.00
'
      )
        .to_stdout
    end
  end
end
