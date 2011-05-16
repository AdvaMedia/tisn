require 'liquid'
class Random < Liquid::Block           
  include Liquid
  Syntax = /(\w+)\s+in\s+(#{QuotedFragment}+)\s*(reversed)?/                                  
  def initialize(tag_name, markup, tokens)
     if markup =~ Syntax
       @variable_name = $1
       @collection_name = $2
       @name = "#{$1}-#{$2}"           
       @reversed = $3             
       @attributes = {}
       markup.scan(TagAttributes) do |key, value|
         @attributes[key] = value
       end        
     else
       raise SyntaxError.new("Syntax Error in 'random' - Valid syntax: random [item] in [collection]")
     end
     
     super
  end

  def render(context)
    context.registers[:random] ||= Hash.new(0)
  
    collection = context[@collection_name]
    collection = collection.to_a if collection.is_a?(Range)
  
    return '' unless collection.respond_to?(:each) 
                                               
    from = if @attributes['offset'] == 'continue'
      context.registers[:random][@name].to_i
    else
      context[@attributes['offset']].to_i
    end
      
    limit = context[@attributes['limit']]
    to    = limit ? limit.to_i + from : nil  
        
                     
    segment = slice_collection_using_each(collection, from, to)      
    
    return '' if segment.empty?
    
    segment.reverse! if @reversed

    result = []
      
    length = segment.length            
          
    # Store our progress through the collection for the continue flag
    context.registers[:random][@name] = from + segment.length 
    
    context.stack do
      context[@variable_name] = segment.shuffle.first
      result << render_all(@nodelist, context)
    end
    
    result
  end   
  
  def slice_collection_using_each(collection, from, to)       
    segments = []      
    index = 0      
    yielded = 0
    collection.each do |item|         
              
      if to && to <= index
        break
      end
      
      if from <= index                               
        segments << item
      end                    
              
      index += 1
    end    

    segments
  end 
end

Liquid::Template.register_tag('random', Random)