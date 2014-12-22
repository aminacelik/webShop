class AddCurrencyDataToCurrencies < ActiveRecord::Migration
  def change
  	Currency.create(name: 'BAM', unit: 'KM', exchange_rate: '1.60')
  end
end
