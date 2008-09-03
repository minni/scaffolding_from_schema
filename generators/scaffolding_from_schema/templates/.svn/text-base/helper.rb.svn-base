# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def top_menus
<% if tables.inject(0){|i,t| i + (t.controller_path ? 1 : 0) } > 0 
  paths = tables.map{|t| t.controller_path}.sort{|a,b| "#{a}" <=> "#{b}"}.uniq -%>
  <%= paths.map{|p|
   "if params[:controller] =~ /(" +
     tables.select{|t| t.controller_path == p}.map{|t| t.controller_name.underscore}.join('|') +
     ")/\n\t\t\t[\n\t\t\t\t"+
     tables.select{|t| t.controller_path == p}.map{|t|
       "['#{t.controller_name.humanize}', {:controller => '/#{t.controller_path ? (t.controller_path.underscore + '/') : ''}#{t.controller_name.underscore}'} ]"
     }.join(",\n\t\t\t\t") +
     "\n\t\t\t]"
  }.join("\n\t\tels")
  %>
  end
<% else -%>
    if params[:controller] =~ /(<%= tables.map{|t| t.controller_name.underscore}.join('|') %>)/
      []
    else
      []
    end
<% end -%>
  end

  def side_menus
    [
<% 
if tables.inject(0){|i,t| i + (t.controller_path ? 1 : 0) } > 0
 paths = []
 tables.each{|t|
   tmp = t.controller_path ? t.controller_path.humanize : 'Main'
   unless paths.detect{|p| p[0] == tmp}
     paths << [tmp, "{:controller => '/#{t.controller_path ? (t.controller_path.underscore + '/') : ''}#{t.controller_name.underscore}'}"]
   end
 }
%>
      <%= paths.sort{|a,b|
          "#{a[0] == 'Main' ? 'AAA' : a[0]}" <=> "#{b[0] == 'Main' ? 'AAA' : b[0]}"}.map{|p|
            "['#{p[0]}', #{p[1]} ]"
          }.join(",\n\t\t\t")
      %>
<% else -%>
      <%= tables.map{|t|
        "['#{t.controller_name.humanize}', {:controller => '/#{t.controller_name.underscore}'} ]"
        }.join(",\n\t\t\t") %>
<% end -%>
    ]
  end
  
  def active_scaffold_controller_for(klass)
    <%= tables.map{|t|
      (
        t.controller_path ?
        "return #{t.controller_path.camelize}::#{t.controller_name.camelize}Controller if klass == #{t.class_name}\n" :
        "return #{t.controller_name.camelize}Controller if klass == #{t.class_name}\n"
      )
      }.join("\t\t")
    %>
    return "#{klass}ScaffoldController".constantize rescue super
  end
end