class Sequel::Model
  
  def self.sync
    schema.columns.each do |column|
      begin
        DB.alter_table table_name do
          add_column column[:name], column[:type]
        end
        puts "Sync column #{column[:name]}."
      rescue
      end
    end
  end
  
end