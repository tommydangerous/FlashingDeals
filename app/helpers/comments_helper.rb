module CommentsHelper
	
  def wrap(content)
  	sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end
  
  def wrap_sub(content)
  	sanitize(raw(content.split.map{ |s| wrap_long_string_sub(s) }.join(' ')))
  end
  
  def wrap_box_deal(content)
  	sanitize(raw(content.split.map{ |s| wrap_long_string_box_deal(s) }.join(' ')))
  end
  
  def wrap_box_deal_large(content)
  	sanitize(raw(content.split.map{ |s| wrap_long_string_box_deal_large(s) }.join(' ')))
  end
  
  def wrap_deal_show(content)
  	sanitize(raw(content.split.map{ |s| wrap_long_string_deal_show(s) }.join(' ')))
  end
  
  def wrap_box_deal_name(content)
  	sanitize(raw(content.split.map{ |s| wrap_long_string_box_deal_name(s) }.join(' ')))
  end
  
  def wrap_box_deal_large_name(content)
  	sanitize(raw(content.split.map{ |s| wrap_long_string_box_deal_large_name(s) }.join(' ')))
  end
  
  private
  
    def wrap_long_string(text, max_width = 79)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
      							  text.scan(regex).join(zero_width_space)
    end
    
    def wrap_long_string_sub(text, max_width = 60)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
      							  text.scan(regex).join(zero_width_space)
    end
    
    def wrap_long_string_box_deal(text, max_width = 20)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
      							  text.scan(regex).join(zero_width_space)
    end
    
    def wrap_long_string_box_deal_large(text, max_width = 30)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
      							  text.scan(regex).join(zero_width_space)
    end
    
    def wrap_long_string_deal_show(text, max_width = 41)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
      							  text.scan(regex).join(zero_width_space)
    end
    
    def wrap_long_string_box_deal_name(text, max_width = 31)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
      							  text.scan(regex).join(zero_width_space)
    end
    
    def wrap_long_string_box_deal_large_name(text, max_width = 37)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
      							  text.scan(regex).join(zero_width_space)
    end
end