# ScaffoldingFromSchema
class ScaffoldingFromSchema
  attr_accessor :tables, :db_schema_file
  
  def initialize
    @tables=[]
    @db_schema_file = 'db/schema.rb'
  end
  
  def parse(&block)
    @tables=[]
    puts "Analyzing schema.rb"
    instance_eval(&block)
    parse_relations
  end
  
  def method_missing(method_id, *args, &block)
    #puts "ERR - Manca la definizione del metodo #{method_id}"
  end
  
  def create_table(table_name, options = {})
    @tables << SfsTable.new(table_name, options){|t|
      yield t
    }
  end
  
  def parse_relations
    puts "Analyze ralationships"
    @tables.each{|t|
      t.fields.each{|f|
        if f.name =~ /^(.*)_id$/
          linked_table_name = "#{$1}_id"
          linked_table = @tables.detect{|tt| tt.foreign_key == linked_table_name}
          unless linked_table
          else
            t.belongs_to << linked_table
            linked_table.has_many << t
          end
        end
      }
    }
  end
end