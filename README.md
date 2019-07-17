[![Coverage Status](https://coveralls.io/repos/github/AdrienFabre/vending-machine/badge.svg?branch=master)](https://coveralls.io/github/AdrienFabre/vending-machine?branch=master)
[![Build Status](https://travis-ci.org/AdrienFabre/vending-machine.svg?branch=master)](https://travis-ci.org/AdrienFabre/vending-machine.svg?branch=master)

# Vending Machine

The aim of this program is to help customers and managers to use the vending machine.

I decided to create the 3 classes you can see below. I have experimented different designs using sequence diagrams and class diagrams in order to simplify the Vending Machine class. I arrived to the conclusion that if I want greatly improve the design I would perfect a design first and then redo it. The current program works, is tested and satisfies all the requirements.

```md
Vending Machine
  attributes
  - items
  - change
  - display
  - dispenser
  - change_converter
  - order
  public methods
  - show_items
  - select_item(item)
  - insert_money(coin)
  - add_change(new_change)
  - add_items(name, quantity)

Display
  public methods
  - print_items(items)
  - print_message(order)

Dispenser
  public methods
  - dispense_change(coin)
  - dispense_item(item)
```


## Requirements

- Once an item is selected and the appropriate amount of money is inserted, the vending machine returns the correct product.
- It returns change if too much money is provided, or ask for more money if insufficient funds have been inserted.
- The machine takes an initial load of products and change. The change will be of denominations 1p, 2p, 5p, 10p, 20p, 50p, £1, £2.
- There is a way of reloading either products or change at a later point.
- The machine keeps track of the products and change that it contains.

## Technology

Ruby

Rspec

## Installation

```md
bundle install
```

## Test

```md
rspec
```

### Results

```md
Display
  in sleep mode
    displays the list of items
  receive a balance = 0
    displays the selected item
  receive not enough money
    displays the missing money message
  receive too much money
    displays here is your change message

user_stories:
  when the machine is in sleep mode
    displays a list of items with prices
  when the machine receives the right amount of money
    displays the selected item
  when the machine receives the right amount of money in 2 times
    displays the selected item
  when the machine receives a new order after an uncompleted order
    the inserted change is returned
  when the machine receives not enough money
    displays the missing money message
  when the machine receives too much money
    displays here is your change message
    accepts and gives the precise change

VendingMachine
  in sleep mode
    returns the list as an array of hashes
  receive the right amount of money
    returns the selected item
  receive not enough money
    returns the missing money value
  receive too much money
    returns the change value
  when the machine receives a new order after an uncompleted order
    the inserted change is returned
  keeps track of the change
    updates the change
  keeps track of the items
    updates the items
  adds change
    updates the change
  add items
    updates the items

Finished in 0.01079 seconds (files took 0.13595 seconds to load)
20 examples, 0 failures

Coverage report generated for RSpec to /home/adrien/Projects/ruby/vending-machine/coverage. 206 / 206 LOC (100.0%) covered.
```

## Execute Linter auto-correct

```md
bundle exec rbprettier --write '**/*.rb'
```

## User Stories

```md
As a user,
So I can choose an item,
I want to see a list of items with their prices.

As a user,
So I can buy an item,
I want to get the item I select when I insert the right amount of money.

As a user,
So I can know if I did not insert enough money,
I want to be asked to insert more money.

As a user,
So I can take my change if I insert too much money,
I want my change to be returned.

As a user,
So I can decide to load any products in the machine,
I want to enter an initial product load.

As a user,
So I can decide to load any quantity of change,
I want to enter an initial change load.

As a user,
So I can give back precise change,
I want the available change to be: 1p, 2p, 5p, 10p, 20p, 50p, £1, £2.

As a user,
So I can reload the products,
I want to be able to load products anytime.

As a user,
So I can reload the change,
I want to be able to load change anytime.

As a user,
So I can keep track of the product load,
I want to be able to read the product load.

As a user,
So I can keep track of the change load,
I want to be able to read the change load.

```

## Edge Cases

```md
The money can be inserted in several times.
If the select_item is used while the money is not enough, the money in the machine is dispensed to the user.

```
