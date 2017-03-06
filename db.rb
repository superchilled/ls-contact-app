# db.rb

require 'sequel'
require 'pry'

DB = Sequel.connect("postgres://karl:nikita@localhost/contacts")

Struct.new('Result', :total, :size, :selection)

class DatabaseConnection
  def initialize(logger)
    DB.logger = logger
  end

  def contact_list(offset)
    total = DB[:contacts].count
    selection = DB[:contacts].limit(1, offset).select(:id, :name)
    Struct::Result.new(total, selection.count, selection)
  end

  def get_contact(id)
    DB[:contacts].first(:id=>id)
  end

  def create_contact(data)
    DB[:contacts].insert(data)
  end

  def update_contact(id, data)
    DB[:contacts].where(:id=>id).update(data)
  end

  def delete_contact(id)
    DB[:contacts].where(:id=>id).delete
  end
end