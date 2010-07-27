class Widget < Sequel::Model
  
  set_schema do
    primary_key :id
    varchar :title
    varchar :content
    integer :order
    boolean :admin
  end
  
  unless table_exists?
    create_table
    create(
      :title => 'Subscribe',
      :content => '<ul id="feed"><li><a href="/feed">Feed</a></li></ul>',
      :order => 10
    )
  end
  
  sync
  
end