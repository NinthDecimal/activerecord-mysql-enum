# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record/mysql_enum/version'

Gem::Specification.new do |spec|
  spec.name          = "activerecord-mysql-enum"
  spec.version       = ActiveRecord::MysqlEnum::VERSION
  spec.authors       = ["Vladimir Kurnavenkov"]
  spec.email         = ["vkurnavenkov@gmail.com"]
  spec.summary       = "The MySQL ENUM type as a string value for ActiveRecord"
  spec.description   = "The library extends support for the MySQL ENUM type for ActiveRecord"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", "~> 5.1.0"
  spec.add_dependency "mysql2", "~> 0.4.4"
end
