module HomeHelper
  def sortable(column, title = nil, css_id = nil)  
    title ||= column.titleize  
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil  
    direction = (column == params[:sort] && params[:order] == "asc") ? "desc" : "asc"  
    content = title + "<i class='icon-caret-down'></i>" + "<i class='icon-caret-up'></i>"
    link_to content.html_safe, params.merge(:sort => column, :order => direction, :page => nil), {:class => css_class, :id => css_id}
  end
end
