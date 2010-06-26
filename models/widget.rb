class Widget < Sequel::Model
  
  set_schema do
    primary_key :id
    varchar :title
    varchar :content
  end
  
  create_table unless table_exists?
  
end