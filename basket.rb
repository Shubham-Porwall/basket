class Basket
  PRODUCTS = {
    'R01' => { name: 'Red Widget', price: 32.95 },
    'G01' => { name: 'Green Widget', price: 24.95 },
    'B01' => { name: 'Blue Widget', price: 7.95 }
  }.freeze

  def initialize
    @items = []
  end

  def add(product_code)
    return @items << product_code if PRODUCTS.key?(product_code)

    puts "Unknown product code: '#{product_code}'"
  end

  def total
    subtotal = calculate_subtotal
    format('$%.2f', subtotal)
  end

  private

  def calculate_subtotal
    @items.sum { |code| PRODUCTS[code][:price] }
  end
end