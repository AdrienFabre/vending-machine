[![Build Status](https://travis-ci.org/AdrienFabre/vending-machine.svg?branch=master)](https://travis-ci.org/AdrienFabre/vending-machine.svg?branch=master)
[![Coverage Status](https://coveralls.io/repos/github/AdrienFabre/bank_tech_test_ruby/badge.svg?branch=master)](https://coveralls.io/github/AdrienFabre/vending-machine?branch=master)

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
