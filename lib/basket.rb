# frozen_string_literal: true

require_relative 'product'
require_relative 'delivery_rule'

# Basket class to manage products, offers, and delivery rules
class Basket
  def initialize(products, delivery_rules, offers = [])
    @product_catalog = products
    @delivery_rule = delivery_rules
    @offers = offers
    @items = []
  end

  def add(product_code)
    product = @product_catalog.find { |p| p.code == product_code }
    puts "Unknown product code: #{product_code}" unless product
    @items << product
  end

  def total
    subtotal = calculate_subtotal
    discount = calculate_total_discount
    delivery = @delivery_rule.calculate(subtotal - discount)
    subtotal - discount + delivery
  end

  private

  def calculate_subtotal
    @items.sum(&:price)
  end

  def calculate_total_discount
    grouped_items.sum do |product, count|
      calculate_offer_discount(product.code, count, product.price)
    end
  end

  def calculate_offer_discount(code, count, price)
    offer = @offers.find { |o| o.code == code }
    return 0 unless offer

    case offer.type
    when :bogo
      eligible_pairs = count / 2
      eligible_pairs * (price * offer.details[:discount])
    else
      0
    end
  end

  def grouped_items
    @items.tally
  end
end
