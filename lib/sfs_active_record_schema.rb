require 'scaffolding_from_schema'
require 'sfs_table'
require 'sfs_column'

module ActiveRecord
  class Schema
    @@version = nil
    @@sfs = nil
    
    def self.define(options = {}, &block)
      @@version = options[:version] || '0'
      @@sfs = ScaffoldingFromSchema.new
      @@sfs.parse(&block)
    end
    
    def self.version
      @@version
    end
    
    def self.sfs
      @@sfs
    end
  end
end