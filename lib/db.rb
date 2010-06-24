require 'sequel'

DB = Sequel.connect 'sqlite://wind.db'

Sequel::Model.plugin :schema

class Post < Sequel::Model
  set_schema do
    primary_key :id
    varchar :title
    varchar :text
    datetime :date
  end
  create_table unless table_exists?
end