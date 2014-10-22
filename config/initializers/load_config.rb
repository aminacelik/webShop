
Rails.logger.info " *** Loading app configuration..."



env = Rails.env.development? ? "development" : "production"
CFG = YAML.load_file("#{Rails.root}/config/config.yml")[env]
Rails.logger.info " *** [DONE] Loading app configuration..."

puts " config = #{CFG}"
puts " config[:secret_key] = #{CFG['secret_key']}"