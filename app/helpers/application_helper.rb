module ApplicationHelper
	
  def logo
  	if signed_in?
  		if current_user.partner.nil?
  			link_to image_tag("logo_beta_s.png", :class => "logo round"), root_path
  		else
  			link_to image_tag("logo_beta_s.png", :class => "logo round"), "/#{current_user.partner}"
  		end
  	else
  		link_to image_tag("logo_beta_s.png", :class => "logo round"), root_path
  	end
  end
  
  def logo_blog
  	link_to image_tag('logo_beta_s.png', :class => 'logo round'), root_url(host: request.domain)
  end
  
  def logo_iframe
  	image_tag("flashingdeals_logo_iframe.png", :class => "logo round")
  end
  
  def title
  	base_title = "FlashingDeals"
  	if @title.nil?
  	  base_title
  	else
  	  "#{@title}"
  	end
  end
  
  def sortable(column, title = nil)
  	title ||= column.titleize
  	css_class = column == sort_column ? "current #{sort_direction}" : nil
  	direction = column == sort_column && sort_direction == "desc" ? "asc" : "desc"
  	link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
  
  def sortable_create(column, title = nil)
  	title ||= column.titleize
  	css_class = column == sort_column_create ? "current #{sort_direction}" : nil
  	direction = column == sort_column_create && sort_direction == "desc" ? "asc" : "desc"
  	link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
  
  def sortable_time_in(column, title = nil)
  	title ||= column.titleize
  	css_class = column == sort_column_time_in ? "current #{sort_direction}" : nil
  	direction = column == sort_column_time_in && sort_direction == "desc" ? "asc" : "desc"
  	link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
  
  def paginate_range(in_collection, in_tot_count)
	  endnumber = in_collection.offset + in_collection.per_page > in_tot_count ? 
	    in_tot_count : in_collection.offset + in_collection.per_page
	  "Displaying deals #{in_collection.offset + 1} - #{endnumber} of #{in_tot_count} in total"
	end
  
	def paginate_range_m(in_collection, in_tot_count, model)
	  endnumber = in_collection.offset + in_collection.per_page > in_tot_count ? 
	    in_tot_count : in_collection.offset + in_collection.per_page
	  "Displaying #{model}s #{in_collection.offset + 1} - #{endnumber} of #{in_tot_count} in total"
	end
	
	def to_html(str)
		simple_format h(str)
	end
end
