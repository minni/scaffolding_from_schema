class Create<%= table.class_name  %> < ActiveRecord::Migration
  def self.up
    create_table :<%= table.table_name %> do |t|
<% table.fields.each do |attribute| -%>
      t.<%= attribute.type %> :<%= attribute.name %>, :null => <%= attribute.null ? 'false' : 'true' %><%=
        attribute.default   ? ", :default => '#{attribute.default}'" : '' %><%=
        attribute.limit     ? ", :limit => #{attribute.limit}" : '' %><%=
        attribute.precision ? ", :precision => #{attribute.precision}" : '' %><%=
        attribute.scale     ? ", :scale => #{attribute.scale}" : '' %>
<% end -%>
    end
  end

  def self.down
    drop_table :<%= table.table_name %>
  end
end