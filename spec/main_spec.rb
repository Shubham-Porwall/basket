# frozen_string_literal: true
# spec/main_spec.rb
require 'rspec'
require_relative '../main'
require_relative '../lib/product'
require_relative '../lib/basket'
require_relative '../lib/delivery_rule'
require_relative '../lib/offer'


RSpec.describe Main do # rubocop:disable Metrics/BlockLength
  describe '#show_total' do
    it 'prints the basket summary with correct totals for multiple products' do
      main_app = Main.new(%w[R01 R01 R01 G01 G01])

      expect { main_app.show_total }.to output(
        a_string_including(
          'Red Widget (R01) x3 - $98.85',
          'Green Widget (G01) x2 - $49.90',
          'Subtotal:        $148.75',
          'Discount:        -$28.95',
          'Delivery Charge:  $0.00',
          'Total:           $119.80'
        )
      ).to_stdout
    end

    it 'prints the basket summary with delivery charge applied for small basket' do
      main_app = Main.new(['B01'])

      expect { main_app.show_total }.to output(
        a_string_including(
          'Blue Widget (B01) x1 - $7.95',
          'Subtotal:        $7.95',
          'Discount:        -$0.00',
          'Delivery Charge:  $4.95',
          'Total:           $12.90'
        )
      ).to_stdout
    end
  end
end