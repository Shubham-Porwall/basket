# frozen_string_literal: true

# spec/basket_spec.rb
require_relative '../../lib/product'
require_relative '../../lib/offer'
require_relative '../../lib/delivery_rule'
require_relative '../../lib/basket'

RSpec.describe Basket do # rubocop:disable Metrics/BlockLength
  let(:products) do
    [
      Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
      Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
      Product.new(code: 'B01', name: 'Blue Widget', price: 7.95)
    ]
  end

  let(:offers) do
    [
      Offer.new(code: 'R01', type: :bogo, details: { buy: 1, get: 1, discount: 0.5 }),
      Offer.new(code: 'G01', type: :bogo, details: { buy: 1, get: 1, discount: 0.5 })
    ]
  end

  let(:delivery_rule) do
    DeliveryRule.new([
                       { threshold: 50, cost: 4.95 },
                       { threshold: 90, cost: 2.95 },
                       { threshold: Float::INFINITY, cost: 0.00 }
                     ])
  end
  subject(:basket) { described_class.new(products, delivery_rule, offers) }

  describe '#add' do
    it 'adds a product to the basket' do
      basket.add('R01')
      expect(basket.instance_variable_get(:@items).map(&:code)).to include('R01')
    end

    it 'prints a warning for unknown product code' do
      expect { basket.add('X01') }.to output(/Unknown product code: X01/).to_stdout
    end
  end

  describe '#total' do
    context 'without offers' do
      it 'calculates total including delivery' do
        basket_no_offers = described_class.new(products, delivery_rule, [])
        basket_no_offers.add('B01')
        basket_no_offers.add('B01')
        expect { basket_no_offers.total }.to output(/Total:\s+\$20.85/).to_stdout
      end
    end

    context 'with BOGO offers' do
      it 'applies BOGO discount correctly' do
        basket.add('R01')
        basket.add('R01')
        basket.add('G01')
        basket.add('G01')

        subtotal = 32.95 * 2 + 24.95 * 2
        discount = (32.95 * 0.5) + (24.95 * 0.5)
        adjusted_total = subtotal - discount
        delivery = 2.95
        total_price = (adjusted_total + delivery).round(2)

        expect { basket.total }.to output(/Total:\s+\$#{format('%.2f', total_price)}/).to_stdout
      end
    end
  end

  describe '#summary' do
    it 'prints a summary without errors' do
      basket.add('R01')
      basket.add('G01')
      expect { basket.total }.to output(/Basket Summary/).to_stdout
    end
  end
end
