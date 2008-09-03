# desc "Explaining what the task does"
# task :scaffolding_from_schema do
#   # Task goes here
# end
namespace :scaffolding do
  namespace :application do
    namespace :from do
      desc "Creates Application scaffold from schema.rb"
      task :schema => :environment do
        puts "Generate Schema.rb..."
        `rake db:schema:dump`
        require 'rails_generator'
        require 'rails_generator/scripts/generate'
        puts "Generate application"
        Rails::Generator::Scripts::Generate.new.run([ "scaffolding_from_schema", 'all' ])
      end
    end
  end
end