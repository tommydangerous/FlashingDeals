module ApplicationHelper
	
  def logo
  	image_tag("flashingdeals_logo.png", :class => "logo round")
  end
  
  def logo_iframe
  	image_tag("flashingdeals_logo_iframe.png", :class => "logo round")
  end
  
  def title
  	base_title = "FlashingDeals"
  	if @title.nil?
  	  base_title
  	else
  	  "#{base_title} | #{@title}"
  	end
  end
  
  def sortable(column, title = nil)
  	title ||= column.titleize
  	css_class = column == sort_column ? "current #{sort_direction}" : nil
  	direction = column == sort_column && sort_direction == "desc" ? "asc" : "desc"
  	link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
  
	def paginate_range(in_collection, in_tot_count)
	  endnumber = in_collection.offset + in_collection.per_page > in_tot_count ? 
	    in_tot_count : in_collection.offset + in_collection.per_page
	  "Displaying deals #{in_collection.offset + 1} - #{endnumber} of #{in_tot_count} in total"
	end
end
