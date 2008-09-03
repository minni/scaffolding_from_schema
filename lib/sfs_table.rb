#Classe per il parsing delle tabelle
#Riconosce le opzioni aggiunitve:
# table_name
# singular
# plural
# class_name
# foreign_key
# controller_name
# controller_path
class SfsTable
  attr_accessor :name,
    :table_name, :singular, :plural, :class_name, :foreign_key, :controller_name, :controller_path,
    :id, :primary_key,
    :namespace, :logging, :table_definition,
    :fields, :belongs_to, :has_many
    
  def name=(value)
    @name       = "#{value}"
    self.table_name  = @name
    self.singular    = @name.singularize
    self.plural      = @name
    self.class_name  = @name.singularize.camelize
    self.foreign_key = "#{singular}_id"
    self.controller_name = @name
    controller_path  = nil
  end
  
  def initialize(table_name, options = {}, &block)
    self.name = table_name
    
    @id = true
    @primary_key = 'id'
    @namespace = nil
    @logging = nil
    @table_definition = []
    @timestamps = true
    @fields = []
    @belongs_to = []
    @has_many   = []
    
    @id = false if options.include?(:id) && options[:id] == false
    [
      :primary_key    ,
      :namespace      ,
      :logging        ,
      :timestamps     ,
      
      :table_name     ,
      :singular       ,
      :plural         ,
      :class_name     ,
      :foreign_key    ,
      :controller_name,
      :controller_path
    ].each{|param|
      if options[param]
        self.send("@#{param} = ", options[param])
      end
    }
    
    @fields = []
    yield(self)
    @table_definition.each {|l|
      @fields << SfsColumn.new(l, self) if l =~ /^\s*t\.(primary_key|string|text|integer|float|decimal|datetime|timestamp|time|date|binary|boolean)/
    }
  end
  
  def column(name, type, options = {})
    @fields << SfsColumn.new(self, name, type, options)
  end

  %w( string text integer float decimal datetime timestamp time date binary boolean ).each do |column_type|
    class_eval <<-EOV
      def #{column_type}(*args)
        options = args.extract_options!
        column_names = args

        column_names.each { |name| column(name, '#{column_type}', options) }
      end
    EOV
  end
end