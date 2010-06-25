require 'sequel'

DB = Sequel.connect DATABASE

Sequel::Model.plugin :schema

class Post < Sequel::Model
  set_schema do
    primary_key :id
    varchar :title
    varchar :text
    datetime :date
  end
  create_table unless table_exists?
  
  def self.ordered
    filter.order(:date.desc)
  end
  
  def self.search(q)
    value = "%#{q}%"
    filter(:title.like(value) | :text.like(value)).order(:date.desc)
  end
end