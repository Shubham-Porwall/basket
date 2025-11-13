# Acme Widget Co - Shopping Basket

## Overview

This is a **Ruby-based proof-of-concept shopping basket** for Acme Widget Co.
It supports:

- Adding products to a basket
- Calculating **subtotal**
- Applying **offers** (e.g., Buy One Get One Half Price)
- Calculating **delivery charges** based on total

---

## Products

| Product      | Code | Price  |
| ------------ | ---- | ------ |
| Red Widget   | R01  | $32.95 |
| Green Widget | G01  | $24.95 |
| Blue Widget  | B01  | $7.95  |

---

## Delivery Rules

- Orders **under $50** → $4.95 delivery
- Orders **under $90** → $2.95 delivery
- Orders **$90 or more** → free delivery

---

## Offers

- `buy_one_get_one_half` → Buy one product, get the second **50% off**
- Offers are **dynamic** and can be added per product

---

## Usage

Run in **IRB**:

```ruby
require_relative 'main'

main = Main.new(%w[R01 R01 R01 G01 G01])
total = main.show_total
puts "Total: $#{total}"
```
