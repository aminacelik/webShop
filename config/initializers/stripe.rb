#Rails.logger.info " *** Loading stripe configuration..."

#Rails.configuration.stripe = {
#  :publishable_key => ENV['PUBLISHABLE_KEY'],
#  :secret_key      => ENV['SECRET_KEY']
#}

Stripe.api_key = CFG[:secret_key]

#Rails.logger.info " *** [DONE] Loading stripe configuration..."