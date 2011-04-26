module ThinkingSphinx
  class SQLite3Adapter < AbstractAdapter
    def setup
      # Does Sqlite3 actually need to do anything?
    end
    
    def sphinx_identifier
      "sqlite3"
    end
    
    def concatenate(clause, separator = ' ')
      "CONCAT_WS('#{separator}', #{clause})"
    end
    
    def group_concatenate(clause, separator = ' ')
      "GROUP_CONCAT(#{clause} SEPARATOR '#{separator}')"
    end
    
    def cast_to_string(clause)
      "CAST(#{clause} AS CHAR)"
    end
    
    def cast_to_datetime(clause)
      "UNIX_TIMESTAMP(#{clause})"
    end
    
    def cast_to_unsigned(clause)
      "CAST(#{clause} AS UNSIGNED)"
    end
    
    def convert_nulls(clause, default = '')
      default = "'#{default}'" if default.is_a?(String)
      
      "IFNULL(#{clause}, #{default})"
    end
    
    def boolean(value)
      value ? 1 : 0
    end
    
    def crc(clause)
      "CRC32(#{clause})"
    end
    
    def utf8_query_pre
      ""
    end
    
    def time_difference(diff)
      "DATE_SUB(NOW(), INTERVAL #{diff} SECOND)"
    end
  end
end
