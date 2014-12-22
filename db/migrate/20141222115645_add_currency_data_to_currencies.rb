class AddCurrencyDataToCurrencies < ActiveRecord::Migration
  def change
  	Currency.create(name: 'USD', unit: '$', exchange_rate: '1')
  	Currency.create(name: 'BAM', unit: 'KM', exchange_rate: '1.60')
  end
end
