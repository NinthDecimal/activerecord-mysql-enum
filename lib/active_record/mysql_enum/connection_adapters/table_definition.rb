require 'active_record/connection_adapters/abstract/schema_definitions.rb'

module ActiveRecord
  module ConnectionAdapters
    class TableDefinition
      def enum(*args)
        options = args.extract_options!
        column_names = args
        column_names.each { |name| column(name, :enum, options) }
      end
    end
  end
end
