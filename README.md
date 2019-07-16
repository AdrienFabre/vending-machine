[![Coverage Status](https://coveralls.io/repos/github/AdrienFabre/vending-machine/badge.svg?branch=master)](https://coveralls.io/github/AdrienFabre/vending-machine?branch=master)
[![Build Status](https://travis-ci.org/AdrienFabre/vending-machine.svg?branch=master)](https://travis-ci.org/AdrienFabre/vending-machine.svg?branch=master)

# Vending Machine

The aim of this program is to help to manage a vending machine, its products and its change.

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
user_stories:
  when the machine is in sleep mode
    displays a list of items with prices
  when the machine receives the right amount of money
    displays the selected item
  when the machine receives the right amount of money in 2 times
    displays the selected item
  when the machine receives a new order after an uncompleted order
    displays the selected item
  when the machine receives not enough money
    displays the missing money message
  when the machine receives too much money
    displays here is your change message
    accepts and give the precise change

Interface
  in sleep mode
    displays the list of items
  receive a balance = 0
    displays the selected item
  receive not enough money
    displays the missing money message
  receive too much money
    displays here is your change message

VendingMachine
  in sleep mode
    returns the list as an array of hashes
  receive the right amount of money
    returns the selected item
  receive not enough money
    returns the missing money value
  receive too much money
    returns the change value
    keeps track of the change
      updates the change
    keeps track of the items
      updates the items
    adds change
      updates the change
    add items
      updates the items

Finished in 0.00922 seconds (files took 0.13356 seconds to load)
19 examples, 0 failures

Coverage report generated for RSpec to /home/adrien/Projects/ruby/vending-machine/coverage. 178 / 178 LOC (100.0%) covered.
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
If the selection is pushed while the money is not enough, the money is kept in the machine.

```
