# frozen_string_literal: true

# Offer class to represent different types of offers
class Offer
  attr_reader :code, :type, :details

  def initialize(code:, type:, details:)
    @code = code
    @type = type
    @details = details # details example: { buy: 1, get: 1, discount: 0.5 }
  end
end
