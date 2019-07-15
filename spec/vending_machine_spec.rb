require 'vending_machine'

describe VendingMachine do
  items = [
    { name: 'Orange Juice', price: 2 },
    { name: 'Green Smoothie', price: 3 }
  ]

  subject(:vending_machine) { described_class.new(items, interface) }
  let(:interface) { double :interface, print_items: nil, print_message: nil }

  context 'in sleep mode' do
    it 'returns the list as an array of hashes' do
      expect(vending_machine.show_items).to eq(items)
      expect(interface).to have_received(:print_items)
    end
  end

  context 'receive the right amount of money' do
    it 'returns the selected item' do
      item = 'Orange Juice'
      inserted_money = 2
      expect(vending_machine.select_item(item, inserted_money)).to eq(0)
      expect(interface).to have_received(:print_message)
    end
  end

  context 'receive not enough money' do
    it 'returns the missing money value' do
      item = 'Orange Juice'
      inserted_money = 1
      expect(vending_machine.select_item(item, inserted_money)).to eq(-1)
      expect(interface).to have_received(:print_message)
    end
  end

  context 'receive too much money' do
    it 'returns the change value' do
      item = 'Orange Juice'
      inserted_money = 3
      expect(vending_machine.select_item(item, inserted_money)).to eq(1)
      expect(interface).to have_received(:print_message)
    end
  end
end
