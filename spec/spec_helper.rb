require 'rspec'
require 'yaml'
require 'activerecord-mysql-enum'

def root
  root ||= File.expand_path(File.dirname(__FILE__))
end

def load_schema
  # Silence verbose schema loading
  original_stdout = $stdout
  $stdout = StringIO.new
  load(File.join(root, "db", "schema.rb"))
ensure
  $stdout = original_stdout
end

def column_props(table, column)
  result = ActiveRecord::Base.connection.select_one "SHOW FIELDS FROM #{table} WHERE Field='#{column}'"
  { :type => result["Type"], :default => result["Default"], :null => ( result["Null"] == "YES" ) }
end

def dump_schema
  stream = StringIO.new
  ActiveRecord::SchemaDumper.ignore_tables = []
  ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, stream)
  stream.string.lines.select {|l| /^\s*#/.match(l).nil? }.join
end

# Establish DB connection
db_config = YAML::load(IO.read(File.join(root, "db", "database.yml")))
ActiveRecord::Base.configurations = db_config
ActiveRecord::Base.establish_connection(:mysql)

RSpec.configure do |c|
  c.mock_with :rspec
  c.backtrace_exclusion_patterns = [
    /spec_helper/,
    /mysql_enum/
  ]
end
