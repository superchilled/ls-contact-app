# db.rb

require 'sequel'
require 'pry'

DB = Sequel.connect("postgres://karl:nikita@localhost/contacts")

class DatabaseConnection
  def initialize(logger)
    DB.logger = logger
  end

  def contact_list
    DB[:contacts].select(:id, :name)
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