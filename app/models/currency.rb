class Currency < ActiveRecord::Base

	validates :name, :unit, :exchange_rate, presence: true
	validates :name, uniqueness: true



    def get_exchenge_rate_for_usd
      begin
        fx = OpenExchangeRates::Rates.new
        result = fx.convert(1, :from => "USD", :to => name)
      end
      result
    end

    def set_exchenge_rate_for_usd
    	exchange_rate = self.get_exchenge_rate_for_usd
    	self.save!
    end


    def self.get_exchenge_rates_for_usd
    	currencies = Currency.all
    	currencies.each do |c|
    		c.exchange_rate = c.get_exchenge_rate_for_usd
    		c.save!
    	end
    end

end
