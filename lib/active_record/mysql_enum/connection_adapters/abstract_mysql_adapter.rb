require 'active_record/connection_adapters/abstract_mysql_adapter'

module ActiveRecord
  module ConnectionAdapters
    class AbstractMysqlAdapter
      protected

      def initialize_type_map(m) # :nodoc:
        super

        m.register_type(%r(enum)i) do |sql_type|
          limit = sql_type[/^enum\('(.+)'\)/i, 1].split("','").map { |v| v.intern }
          MysqlEnum.new(limit: limit)
        end
      end

      class MysqlEnum < MysqlString
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
