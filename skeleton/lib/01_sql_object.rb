require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    @table ||= DBConnection.execute2(<<-SQL) 
      SELECT -- return the table if it's already defined. Otherwise, query the database 
        *
      FROM
        cats
      LIMIT 0 --optimization because we don't actually want the data in the table
      SQL
    @table.first.map{|el| el.to_sym}
  end

  def self.finalize!
    @cols = self.columns 
    @cols.each do |col|
      define_method("#{col}") do #getter method
        attributes[col] #calls the attributes METHOD!
      end

      define_method("#{col}=") do |new_value| #setter method
        attributes[col] = new_value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name = self.to_s.downcase + 's'
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    @attributes ||= {} #sets it to attributes or an empty hash if it hasn't been defined yet
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
