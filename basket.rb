class Basket
  PRODUCTS = {
    'R01' => { name: 'Red Widget', price: 32.95 },
    'G01' => { name: 'Green Widget', price: 24.95 },
    'B01' => { name: 'Blue Widget', price: 7.95 }
  }.freeze

  DELIVERY_RULES = [
    { threshold: 50, cost: 4.95 },
    { threshold: 90, cost: 2.95 },
    { threshold: Float::INFINITY, cost: 0.00 }
  ].freeze

  def initialize(delivery_rules = DELIVERY_RULES)
    @items = []
    @delivery_rules = delivery_rules
  end

  def add(product_code)
    return @items << product_code if PRODUCTS.key?(product_code)

    puts "Unknown product code: '#{product_code}'"
  end

  def total
    subtotal = calculate_subtotal
    delivery = calculate_delivery(subtotal)
    format('$%.2f', subtotal + delivery)
  end

  def summary
    subtotal = calculate_subtotal
    delivery = calculate_delivery(subtotal)
    total_price = subtotal + delivery

    puts "🛒 Basket Summary"
    puts "-----------------------------"
    grouped_items.each do |code, count|
      product = PRODUCTS[code]
      puts "#{product[:name]} (#{code}) x#{count} - $#{format('%.2f', product[:price] * count)}"
    end
    puts "-----------------------------"
    puts "Subtotal:       $#{format('%.2f', subtotal)}"
    puts "Delivery Charge: $#{format('%.2f', delivery)}"
    puts "Total:          $#{format('%.2f', total_price)}"
    puts "============================="
  end

  private

  def calculate_delivery(subtotal)
    @delivery_rules.find { |rule| subtotal < rule[:threshold] }[:cost]
  end

  def calculate_subtotal
    @items.sum { |code| PRODUCTS[code][:price] }
  end

  def grouped_items
    @items.tally
  end
end
