class UpdateExchangeRatesJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    Currency.get_exchenge_rates_for_usd
  end
end