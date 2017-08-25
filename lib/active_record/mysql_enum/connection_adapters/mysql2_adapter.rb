require 'active_record/connection_adapters/mysql2_adapter'

module ActiveRecord
  module ConnectionAdapters
    class Mysql2Adapter
      # alias __native_database_types_without_enum native_database_types
      def native_database_types_with_enum #:nodoc
        types = native_database_types_without_enum
        types[:enum] = { :name => "enum" }
        types
      end
      alias_method :native_database_types_without_enum, :native_database_types
      alias_method :native_database_types, :native_database_types_with_enum

      # alias __type_to_sql_without_enum type_to_sql
      def type_to_sql_with_enum(type, limit: nil, precision: nil, scale: nil, unsigned: nil, **) # :nodoc:
        if type.to_s == "enum"
          "#{type}(#{quoted_comma_list limit})"
        else
          type_to_sql_without_enum type, limit, *args
        end
      end
      alias_method :type_to_sql_without_enum, :type_to_sql
      alias_method :type_to_sql, :type_to_sql_with_enum

      private
      def quoted_comma_list list
        list.to_a.map{|n| "'#{n}'"}.join(",")
      end
    end
  end
end
