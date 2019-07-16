require 'vending_machine'

describe VendingMachine do
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

  subject(:vending_machine) do
    described_class.new(items: items, change: change, interface: interface)
  end
  let(:interface) { double :interface, print_items: nil, print_message: nil }

  context 'in sleep mode' do
    it 'returns the list as an array of hashes' do
      expect(vending_machine.show_items).to eq(items)
      expect(interface).to have_received(:print_items)
    end
  end

  context 'receive the right amount of money' do
    it 'returns the selected item' do
      vending_machine.select_item('Orange Juice')
      expect(vending_machine.insert_money('£2')).to eq(0)
      expect(interface).to have_received(:print_message)
    end
  end

  context 'receive not enough money' do
    it 'returns the missing money value' do
      vending_machine.select_item('Orange Juice')
      expect(vending_machine.insert_money('£1')).to eq(-1)
      expect(interface).to have_received(:print_message)
    end
  end

  context 'receive too much money' do
    it 'returns the change value' do
      vending_machine.select_item('Orange Juice')
      vending_machine.insert_money('£1')
      expect(vending_machine.insert_money('£2')).to eq(1)
      expect(interface).to have_received(:print_message).twice
    end

    context 'keeps track of the change' do
      it 'updates the change' do
        vending_machine.change = {
          '1p' => 50,
          '2p' => 50,
          '5p' => 50,
          '10p' => 50,
          '20p' => 50,
          '50p' => 50,
          '£1' => 50,
          '£2' => 50
        }
        vending_machine.select_item('Orange Juice')
        vending_machine.insert_money('£1')
        expect(vending_machine.insert_money('£2')).to eq(1)
        expect(vending_machine.change).to eq(
          {
            '1p' => 50,
            '2p' => 50,
            '5p' => 50,
            '10p' => 50,
            '20p' => 50,
            '50p' => 50,
            '£1' => 50,
            '£2' => 51
          }
        )
      end
    end
    context 'keeps track of the items' do
      it 'updates the items' do
        vending_machine.items = [
          { name: 'Orange Juice', price: 2, quantity: 3 },
          { name: 'Green Smoothie', price: 3, quantity: 5 },
          { name: 'Chocolate Bar', price: 4, quantity: 7 }
        ]
        vending_machine.select_item('Orange Juice')
        vending_machine.insert_money('£1')
        expect(vending_machine.insert_money('£2')).to eq(1)
        expect(vending_machine.items).to eq(
          [
            { name: 'Orange Juice', price: 2, quantity: 2 },
            { name: 'Green Smoothie', price: 3, quantity: 5 },
            { name: 'Chocolate Bar', price: 4, quantity: 7 }
          ]
        )
      end
    end

    context 'adds change' do
      it 'updates the change' do
        vending_machine.change = {
          '1p' => 50,
          '2p' => 50,
          '5p' => 50,
          '10p' => 50,
          '20p' => 50,
          '50p' => 50,
          '£1' => 50,
          '£2' => 50
        }
        vending_machine.add_change(
          {
            '1p' => 10,
            '2p' => 10,
            '5p' => 10,
            '10p' => 10,
            '20p' => 20,
            '50p' => 20,
            '£1' => 5,
            '£2' => 5
          }
        )
        expect(vending_machine.change).to eq(
          {
            '1p' => 60,
            '2p' => 60,
            '5p' => 60,
            '10p' => 60,
            '20p' => 70,
            '50p' => 70,
            '£1' => 55,
            '£2' => 55
          }
        )
      end
    end
    describe 'add items' do
      it 'updates the items' do
        vending_machine.items = [
          { name: 'Orange Juice', price: 2, quantity: 3 },
          { name: 'Green Smoothie', price: 3, quantity: 5 },
          { name: 'Chocolate Bar', price: 4, quantity: 7 }
        ]
        expect(vending_machine.add_items('Chocolate Bar', 10)).to eq(
          [
            { name: 'Orange Juice', price: 2, quantity: 3 },
            { name: 'Green Smoothie', price: 3, quantity: 5 },
            { name: 'Chocolate Bar', price: 4, quantity: 17 }
          ]
        )
      end
    end
  end
end
