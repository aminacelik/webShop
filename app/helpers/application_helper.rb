module ApplicationHelper
	
	
def errors_for(model, attribute)
  if model.errors[attribute].present?
    content_tag :span, class: 'error_explanation' do
      model.errors[attribute].first
    end
  end
end

def adapt_currency(price)
	if params[:locale] == 'ba'
		currency = Currency.where(name: 'BAM').first
		price = number_to_currency(price, unit: currency.unit, separator: ",", delimiter: "", format: "%n %u")
	else
		price = number_to_currency(price, unit: "$", separator: ".", delimiter: ",", format: "%u%n")
	end
	
	price
end
	
end
