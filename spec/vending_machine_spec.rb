require 'vending_machine'

describe VendingMachine do
  items = ['Orange Juice £2', 'Green smoothie £3']

  subject(:vending_machine) { described_class.new(items) }

  it 'shows a list of item with prices' do
    expect(vending_machine.show_items).to eq(items)
  end
end
