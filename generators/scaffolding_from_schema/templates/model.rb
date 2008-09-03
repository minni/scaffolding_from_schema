class <%=table.class_name %> < ActiveRecord::Base
  <%="acts_as_logged\n" if table.logging %>
  
<% table.belongs_to.each do |b| -%>
  belongs_to :<%=b.singular %>, :class_name => '<%=b.class_name %>', :foreign_key => '<%=b.foreign_key %>'
<% end -%>
<%= "\n" if table.belongs_to.size > 0 -%>
<% table.has_many.each do |h| -%>
  has_many :<%=h.plural %>, :class_name => '<%=h.class_name %>', :foreign_key => '<%=table.foreign_key %>'
<% end -%>
<%= "\n" if table.has_many.size > 0 -%>
<% table.has_many.each do |h|
  h.belongs_to.select{|bt| bt != table}.each do |bt| -%>
  #has_many :<%= bt.plural %>, :through => <%=h.plural %>
<% end
end -%>
<%= "\n" if table.has_many.inject(0){|i,h| i+h.belongs_to.size} > 0 -%>
  def to_label
    self.to_s
  end
end
