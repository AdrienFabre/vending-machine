require 'dispenser'

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

  change_converter = {
    '1p' => 0.01,
    '2p' => 0.02,
    '5p' => 0.05,
    '10p' => 0.1,
    '20p' => 0.2,
    '50p' => 0.5,
    '£1' => 1,
    '£2' => 2
  }

  let(:display) { Display.new }
  let(:dispenser) { Dispenser.new }
  let(:vending_machine) do
    VendingMachine.new(
      items: items,
      change: change,
      display: display,
      change_converter: change_converter,
      dispenser: dispenser
    )
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
    it 'the inserted change is returned' do
      vending_machine.select_item('Orange Juice')
      expect { vending_machine.insert_money('£1') }.to output(
        "£1.00 is missing!\n"
      )
        .to_stdout
      expect { vending_machine.select_item('Orange Juice') }.to output(
        "Here is your change: £1.00\n"
      )
        .to_stdout
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

  items_popularity = [
    { name: 'Orange Juice', price: 2, quantity: 10 },
    { name: 'Green Smoothie', price: 2, quantity: 10 },
    { name: 'Chocolate Bar', price: 2, quantity: 10 },
    { name: 'Croissant', price: 2, quantity: 10 },
    { name: 'Hot chocolate', price: 2, quantity: 10 },
    { name: 'Banana', price: 2, quantity: 10 }
  ]

  context 'when I want analyse my sales' do
    let(:vending_machine) do
      VendingMachine.new(
        items: items_popularity,
        change: change,
        display: display,
        change_converter: change_converter,
        dispenser: dispenser
      )
    end
    it 'displays the top 3 most popular items' do
      vending_machine.select_item('Orange Juice')
      expect { vending_machine.insert_money('£2') }.to output("Orange Juice\n")
        .to_stdout
      vending_machine.select_item('Orange Juice')
      expect { vending_machine.insert_money('£2') }.to output("Orange Juice\n")
        .to_stdout
      vending_machine.select_item('Chocolate Bar')
      expect { vending_machine.insert_money('£2') }.to output("Chocolate Bar\n")
        .to_stdout
      vending_machine.select_item('Chocolate Bar')
      expect { vending_machine.insert_money('£2') }.to output("Chocolate Bar\n")
        .to_stdout
      vending_machine.select_item('Banana')
      expect { vending_machine.insert_money('£2') }.to output("Banana\n")
        .to_stdout
      expect { vending_machine.sales_report }.to output(
        "Orange Juice, Chocolate Bar, Banana\n"
      )
        .to_stdout
    end
  end
end
