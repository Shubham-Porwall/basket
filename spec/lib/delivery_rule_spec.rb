# frozen_string_literal: true

require_relative '../../lib/delivery_rule'

RSpec.describe DeliveryRule do # rubocop:disable Metrics/BlockLength
  let(:rules) do
    [
      { threshold: 50, cost: 4.95 },
      { threshold: 90, cost: 2.95 },
      { threshold: Float::INFINITY, cost: 0.0 }
    ]
  end

  subject(:delivery_rule) { described_class.new(rules) }

  describe '#calculate' do
    it 'returns the correct delivery cost for subtotal below first threshold' do
      expect(delivery_rule.calculate(30)).to eq(4.95)
    end

    it 'returns the correct delivery cost for subtotal between thresholds' do
      expect(delivery_rule.calculate(70)).to eq(2.95)
    end

    it 'returns zero delivery cost for subtotal above last threshold' do
      expect(delivery_rule.calculate(150)).to eq(0.0)
    end

    it 'returns zero if rules are empty' do
      empty_rule = described_class.new([])
      expect(empty_rule.calculate(50)).to eq(0.0)
    end

    it 'handles subtotal exactly equal to a threshold correctly' do
      expect(delivery_rule.calculate(50)).to eq(2.95)
      expect(delivery_rule.calculate(90)).to eq(0.0)
    end
  end
end
