ENV['RACK_ENV'] ||= "development"
ENV['DB_HOST'] = "postgresql-db-server-do-user-7074878-0.a.db.ondigitalocean.com"
ENV['DB_PASSWORD'] = "z8pb3bifrqm36aa4"

# require common gems in Gemfile with 'bundler/setup'
require 'bundler/setup'
# Require the gems in a specific ENV['RACK_ENV'] group
Bundler.require(:default, ENV['RACK_ENV'])

ActiveRecord::Base.establish_connection(ENV['RACK_ENV'].to_sym)
# Since we can’t dump a tsvector column to schema.rb, 
# we need to switch to the SQL schema format 
ActiveRecord::Base.schema_format = :sql

# tell activerecord to automatically set id = n + 1
ActiveRecord::Base.connection.tables.each do |table_name| 
  ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
end

require_all 'app'

