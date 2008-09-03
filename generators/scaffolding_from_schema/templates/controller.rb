<%
columns = table.fields.map{|f| ":#{f.name}"} +
          table.belongs_to.map{|b| ":#{b.singular}"} +
          table.has_many.map{|h| ":#{h.plural}"}
columns.delete(':created_at')
columns.delete(':updated_at')
columns.delete(':id')
columns = columns.select{|c| c.to_s !~ /_id$/ }
%>class <%= table.controller_name.camelize %>Controller < ApplicationController

  before_filter :set_title
  
  def set_title
    @title = '<%=table.controller_name.camelize.humanize %>'
  end
  
  active_scaffold :<%= table.class_name.underscore %> do |config|
    #config.actions.exclude :show
    #config.actions.exclude :delete
    
    #config.update.link.inline = false
    #config.create.link.inline = false
    
    config.actions.add :live_search
    
    config.columns = [:id, <%= columns.join(', ') %>]
    config.list.columns = [:id, <%= columns.join(', ') %>]
    config.update.columns = [<%= columns.join(', ') %>]
    config.create.columns = [<%= columns.join(', ') %>]
  end
end
