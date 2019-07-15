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
      money = 2
      vending_machine.select_item(item)
      expect { vending_machine.insert_money(money) }.to output('Orange Juice
')
        .to_stdout
    end
  end

  context 'when the machine receives the right amount of money in 2 times' do
    it 'displays the selected item' do
      item = 'Orange Juice'
      money = 1
      vending_machine.select_item(item)
      expect { vending_machine.insert_money(money) }.to output(
        '£1.00 is missing!
'
      )
        .to_stdout
      expect { vending_machine.insert_money(money) }.to output('Orange Juice
')
        .to_stdout
    end
  end

  context 'when the machine receives a new order after an uncompleted order' do
    it 'displays the selected item' do
      item_1 = 'Orange Juice'
      money_1 = 1
      vending_machine.select_item(item_1)
      expect { vending_machine.insert_money(money_1) }.to output(
        '£1.00 is missing!
'
      )
        .to_stdout
      item_2 = 'Green Smoothie'
      money_2 = 3
      vending_machine.select_item(item_2)
      expect { vending_machine.insert_money(money_2) }.to output('Green Smoothie
')
        .to_stdout
    end
  end

  context 'when the machine receives not enough money' do
    it 'displays the missing money message' do
      item = 'Orange Juice'
      money = 1
      vending_machine.select_item(item)
      expect { vending_machine.insert_money(money) }.to output(
        '£1.00 is missing!
'
      )
        .to_stdout
    end
  end

  context 'when the machine receives too much money' do
    it 'displays here is your change message' do
      item = 'Orange Juice'
      money = 3
      vending_machine.select_item(item)
      expect { vending_machine.insert_money(money) }.to output(
        'Here is your change: £1.00
'
      )
        .to_stdout
    end
  end
end
