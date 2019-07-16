describe 'user_stories:' do
  items = [
    { name: 'Orange Juice', price: 2, quantity: 3 },
    { name: 'Green Smoothie', price: 3, quantity: 5 },
    { name: 'Chocolate Bar', price: 4, quantity: 7 }
  ]

  change = {
    '1p' => 50,
    '2p' => 50,
    '5p' => 50,
    '10p' => 50,
    '20p' => 50,
    '50p' => 50,
    '£1' => 50,
    '£2' => 50
  }

  subject(:interface) { Interface.new }
  subject(:vending_machine) do
    VendingMachine.new(items: items, change: change, interface: interface)
  end

  context 'when the machine is in sleep mode' do
    it 'displays a list of items with prices' do
      expect { vending_machine.show_items }.to output(
        "Orange Juice £2.00\nGreen Smoothie £3.00\nChocolate Bar £4.00\n"
      )
        .to_stdout
    end
  end

  context 'when the machine receives the right amount of money' do
    it 'displays the selected item' do
      vending_machine.select_item('Orange Juice')
      expect { vending_machine.insert_money('£2') }.to output("Orange Juice\n")
        .to_stdout
    end
  end

  context 'when the machine receives the right amount of money in 2 times' do
    it 'displays the selected item' do
      vending_machine.select_item('Orange Juice')
      expect { vending_machine.insert_money('£1') }.to output(
        "£1.00 is missing!\n"
      )
        .to_stdout
      expect { vending_machine.insert_money('£1') }.to output("Orange Juice\n")
        .to_stdout
    end
  end

  context 'when the machine receives a new order after an uncompleted order' do
    it 'displays the selected item' do
      vending_machine.select_item('Orange Juice')
      expect { vending_machine.insert_money('£1') }.to output(
        "£1.00 is missing!\n"
      )
        .to_stdout
      vending_machine.select_item('Orange Juice')
      expect { vending_machine.insert_money('£2') }.to output("Orange Juice\n")
        .to_stdout
    end
  end

  context 'when the machine receives not enough money' do
    it 'displays the missing money message' do
      vending_machine.select_item('Orange Juice')
      expect { vending_machine.insert_money('£1') }.to output(
        "£1.00 is missing!\n"
      )
        .to_stdout
    end
  end

  context 'when the machine receives too much money' do
    it 'displays here is your change message' do
      vending_machine.select_item('Orange Juice')
      expect { vending_machine.insert_money('£1') }.to output(
        "£1.00 is missing!\n"
      )
        .to_stdout
      expect { vending_machine.insert_money('£2') }.to output(
        "Here is your change: £1.00\n"
      )
        .to_stdout
    end

    it 'accepts and gives the precise change' do
      item = 'Orange Juice'
      vending_machine.select_item(item)
      expect { vending_machine.insert_money('50p') }.to output(
        "£1.50 is missing!\n"
      )
        .to_stdout
      expect { vending_machine.insert_money('20p') }.to output(
        "£1.30 is missing!\n"
      )
        .to_stdout
      expect { vending_machine.insert_money('£1') }.to output(
        "£0.30 is missing!\n"
      )
        .to_stdout

      expect { vending_machine.insert_money('£2') }.to output(
        "Here is your change: £1.70\n"
      )
        .to_stdout
    end
  end
end
