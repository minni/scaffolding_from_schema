class ScaffoldingFromSchemaGenerator < Rails::Generator::NamedBase
  default_options :db_schema     => 'db/schema.rb',
    :skip_migration              => false,
    :skip_models                 => false,
    :skip_controller             => false,
    :skip_application_controller => false,
    :skip_application_helper     => false,
    :skip_layout                 => false
    
  attr_accessor :what
  
  def initialize(runtime_args, runtime_options = {})
    super    
    @what = [class_name] + args
    #puts "#{@what.size} ARGOMENTI: #{@what.join(',')}"
  end
  
  def manifest
    record do |m|
      # m.directory "lib"
      # m.template 'README', "README"
      require 'sfs_active_record_schema'
      
      puts "Leggo schema.rb da #{options[:db_schema]}"
      unless File.exists?("#{options[:db_schema]}") || File.exists?("#{options[:db_schema]}.rb")
        puts "\n\nERRORE: File #{options[:db_schema]} INESISTENTE!\n\n"
        exit
      end
      require options[:db_schema]
      sfs = ActiveRecord::Schema.sfs
      
      #require 'pp'
      #pp ActiveRecord::Schema.sfs
      #File.open('tmp/risultato.yml', 'w'){|f| f.write ActiveRecord::Schema.sfs.to_yaml}
      
      puts "Verifica presenza ActiveScaffold"
      unless File.exists?('vendor/plugins/active_scaffold')
        puts "\n\nERRORE: Plugin Active NON installato!\nAndare su http://www.activescaffold.com\n\n"
        exit
        #puts "Install required active_scaffold..."
        #`cd vendor/plugins; wget http://github.com/tarballs/activescaffold-active_scaffold-e38b2381baf24ed58df64719da324a9c1559b6a7.tar.gz; tar zxvf activescaffold-active_scaffold-e38b2381baf24ed58df64719da324a9c1559b6a7.tar.gz; mv activescaffold-active_scaffold-e38b2381baf24ed58df64719da324a9c1559b6a7 active_scaffold; cd ../..`
      end
      
      puts "Verifica tabelle da importare..."
      if "#{@what[0]}".downcase == 'all'
        @scan_tables = sfs.tables.map {|t| t }
        puts "Intero schema database: "+ @scan_tables.map{|t| t.name}.join(',')
      else
        puts "Intero le tabllle:"
        @scan_tables = []
        @what.each{|w|
          if tmp = sfs.tables.detect{|t| t.name == "#{w}".underscore }
            @scan_tables << tmp
            puts "   #{tmp.name}"
          end
        }
        puts "\n   #{@scan_tables.size} tabelle da scansire"
      end
        
      unless options[:skip_migrations]
        puts "Creo le migrazioni"
        m.directory File.join('db')
        FileUtils.mkdir('db/migrate') unless File.exists?('db/migrate')
        @scan_tables.each{|t|
          m.migration_template 'migration.rb', 'db/migrate',
            :migration_file_name => "create_#{t.class_name.underscore}",
            :assigns => {:table => t}
        }
      end
         
      unless options[:skip_models]
        puts "Creo i modelli"
        m.directory File.join('app/models')
        @scan_tables.each{|t|
          m.template 'model.rb',
            File.join('app/models', "#{t.class_name.underscore}.rb"),
            :assigns => {:table => t}
          if tmp = t.fields.detect{|c| c.types.split(',').size > 0}
            tmp.types.split(',').each{|child_name|
              m.template 'model_child.rb',
                File.join('app/models', "#{child_name.underscore}.rb"),
                :assigns => {:child_name => child_name, :table => t}
            }
          end
        }
      end
      
      unless options[:skip_controller]
        puts "Creo i controller"
        m.directory File.join('app/controllers')
        @scan_tables.each{|t|
          m.template 'controller.rb',
            File.join('app/controllers', "#{t.controller_name.underscore}_controller.rb"),
            :assigns => {:table => t}
        }
      end
      
      unless options[:skip_application_controller]
        puts "Creo l'application controller"
        m.template 'application.rb',
          File.join('app/controllers', "application.rb"),
          :assigns => {:tables => @scan_tables}
      end
      
      unless options[:skip_layout]
        puts "Creo il layout"
        m.directory File.join('app/views/layouts')
        m.directory File.join('config')
        m.template 'application.html.erb',
          File.join('app/views/layouts', "application.html.erb"),
          :assigns => {:tables => @scan_tables}
        m.template '_side_menu.html.erb',
          File.join('app/views/layouts', "_side_menu.html.erb"),
          :assigns => {:tables => @scan_tables}
        m.template '_top_menu.html.erb',
          File.join('app/views/layouts', "_top_menu.html.erb"),
          :assigns => {:tables => @scan_tables}
        m.template 'routes.rb',
          File.join('config', "routes.rb"),
          :assigns => {:tables => @scan_tables}
        #TODO: SCRIVERLA ANCHE PER WINZ
        `cp -pr vendor/plugins/scaffolding_from_schema/generators/scaffolding_from_schema/templates/public/* public/`
        `mv public/index.html public/_index.html`
      end
      
      unless options[:skip_application_helper]
        puts "Creo l'application controller"
        m.directory File.join('app/helpers')
        m.template 'helper.rb',
          File.join('app/helpers', "application_helper.rb"),
          :assigns => {:tables => @scan_tables}
      end
    end
  end
  
  
protected
  def banner
    "Usage: #{$0} #{spec.name} TableName"
  end

  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("--db_schema=db_schama_path",
           "Specify schema.rb (default db/shema.rb)"){ |v| options[:db_schema] = v }
    opt.on("--skip_migration",
           "Don't generate a migration") { |v| options[:skip_migration] = v }
    opt.on("--skip_models",
           "Don't generate a models") { |v| options[:skip_models] = v }
    opt.on("--skip_controller",
           "Don't generate a controller") { |v| options[:skip_controller] = v }
    opt.on("--skip_application_controller",
           "Don't generate a application_controller") { |v| options[:skip_application_controller] = v }
    opt.on("--skip_application_helper",
           "Don't generate a application_helper") { |v| options[:skip_application_helper] = v }
    opt.on("--skip_layout",
           "Don't generate a layout") { |v| options[:skip_layout] = v }
    #opt.on("--skip-migration", 
    #       "Don't generate a migration file for this model") { |v| options[:skip_migration] = v }
    #opt.on("--skip-fixture",
    #       "Don't generation a fixture file for this model") { |v| options[:skip_fixture] = v}
  end
end
