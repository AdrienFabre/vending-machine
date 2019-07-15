describe 'user_stories:' do
  items = [
    { name: 'Orange Juice', price: 2 },
    { name: 'Green Smoothie', price: 3 }
  ]

  subject(:interface) { Interface.new }
  subject(:vending_machine) { VendingMachine.new(items, interface) }

  context 'when the machine is in sleep mode' do
    it 'displays a list of items with prices' do
      expect { vending_machine.show_items }.to output(
        'Orange Juice £2.00
Green Smoothie £3.00
'
      )
        .to_stdout
    end
  end

  context 'when the machine receives the right amount of money' do
    it 'displays the selected item' do
      item = 'Orange Juice'
      inserted_money = 2
      expect { vending_machine.select_item(item, inserted_money) }.to output(
        'Orange Juice
'
      )
        .to_stdout
    end
  end

  context 'when the machine receives not enough money' do
    it 'displays the missing money message' do
      item = 'Orange Juice'
      inserted_money = 1
      expect { vending_machine.select_item(item, inserted_money) }.to output(
        '£1.00 is missing!
'
      )
        .to_stdout
    end
  end

  context 'when the machine receives too much money' do
    it 'displays here is your change message' do
      item = 'Orange Juice'
      inserted_money = 3
      expect { vending_machine.select_item(item, inserted_money) }.to output(
        'Here is your change: £1.00
'
      )
        .to_stdout
    end
  end
end
