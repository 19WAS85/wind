class Setting < Sequel::Model
  
  set_schema do
    primary_key :id
    varchar :name
    varchar :title
    varchar :code
    varchar :feed
    varchar :footer
    varchar :tracker
  end
  
  unless table_exists?
    create_table
    create(
      :name => 'Wind',
      :title => 'A simple way to think',
      :code => 'admin'
    )
  end
  
  sync
  
  def self.from_database
    filter.first
  end
  
end