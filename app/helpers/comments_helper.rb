module CommentsHelper
	
  def wrap(content)
  	sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end
  
  def wrap_sub(content)
  	sanitize(raw(content.split.map{ |s| wrap_long_string_sub(s) }.join(' ')))
  end
  
  private
  
    def wrap_long_string(text, max_width = 115)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
      							  text.scan(regex).join(zero_width_space)
    end
    
    def wrap_long_string_sub(text, max_width = 90)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
      							  text.scan(regex).join(zero_width_space)
    end
end