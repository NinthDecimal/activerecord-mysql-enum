require 'active_record/connection_adapters/abstract_mysql_adapter'

module ActiveRecord
  module ConnectionAdapters
    class AbstractMysqlAdapter
      protected

      # alias __initialize_type_map_without_enum initialize_type_map
      def initialize_type_map_with_enum(m = type_map) # :nodoc:
        initialize_type_map_without_enum(m)

        m.register_type(%r(enum)i) do |sql_type|
          limit = sql_type[/^enum\('(.+)'\)/i, 1].split("','").map { |v| v.intern }
          MysqlEnum.new(limit: limit)
        end
      end
      alias_method :initialize_type_map_without_enum, :initialize_type_map
      alias_method :initialize_type_map, :initialize_type_map_with_enum

      class MysqlEnum < MysqlString
        def type
          :enum
        end

        def type_cast_for_database(value)
          value_to_symbol(super(value))
        end

        private

        def cast_value(value)
          value_to_symbol(super(value))
        end

        def value_to_symbol(value)
          case value
          when Symbol
            value
          when String
            value.empty? ? nil : value.intern
          else
            nil
          end
        end

      end
    end
  end
end
