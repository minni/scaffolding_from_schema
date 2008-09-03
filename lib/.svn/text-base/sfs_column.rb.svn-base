#Classe per il parsing dei campi
#Riconosce le opzioni aggiunitve:
# types - Elenco delle classi derivate, separate da virgola
# label
# list_view
# show_view
# create_view
# update_view
class SfsColumn
  attr_accessor :name, :type, :limit, :default, :null, :precision, :scale,
    :label, :list_view, :show_view, :create_view, :update_view,
    :types, :table
  
  def initialize(table, name, type, options = {})
    @table     = table
    
    @name      = name
    @type      = type
    
    @limit     = options[:limit]
    @default   = options[:default]
    @null      = options[:null]
    @precision = options[:precision]
    @scale     = options[:scale]
    
    @label       = options[:label] || "#{@name}".humanize
    @list_view   = options.include?(:list_view  ) ? options[:list_view  ] : true
    @show_view   = options.include?(:show_view  ) ? options[:show_view  ] : true
    @create_view = options.include?(:create_view) ? options[:create_view] : true
    @update_view = options.include?(:update_view) ? options[:update_view] : true
    
    @types       = ''
    if "#{@name}" == 'type'
      unless @types.split(',').size > 0
        begin
          @types = ActiveRecord::Base.connection.select_all(
            "SELECT type FROM #{@table.name} GROUP BY type").map{|r|
            r['type'] == @table.class_name ? nil : r['type']
          }.compact.join(',')
        rescue
          @types = "#{@table.class_name}TypeA,#{@table.class_name}TypeB"
	  puts "WARN - No Types defined for table #{@table.name}"
        end
        unless @types.split(',').size > 0
          @types = "#{@table.class_name}TypeA,#{@table.class_name}TypeB"
	        puts "WARN - No Types defined for table #{@table.name}"
        end	
      end
    end
  end
end
