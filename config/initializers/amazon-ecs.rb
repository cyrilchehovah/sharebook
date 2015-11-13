require 'amazon/ecs'

Amazon::Ecs.configure do |options|
  options[:AWS_access_key_id] = ENV["AWS_ECS_KEY"]
  options[:AWS_secret_key]    = ENV["AWS_ECS_SECRET"]
  options[:associate_tag]     = 'sharebook08-21'
end
