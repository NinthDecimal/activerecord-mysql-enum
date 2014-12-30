require "active_record/mysql_enum/version"

if defined?(::Rails::Railtie)
  class ActiveRecordMysqlEnumRailtie < Rails::Railtie
    initializer 'enum_column.initialize', after: 'active_record.initialize_database' do |app|
      ActiveSupport.on_load :active_record do
        require "active_record/mysql_enum/connection_adapters"
      end

      ActiveSupport.on_load :action_view do
        require "active_record/mysql_enum/helpers"
      end
    end
  end
else
  require "active_record/mysql_enum/connection_adapters"
end
