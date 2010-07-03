class Widget < Sequel::Model
  
  set_schema do
    primary_key :id
    varchar :title
    varchar :content
    integer :order
  end
  
  create_table?
  
  sync
  
end