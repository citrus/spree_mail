class CreateSpreeMailLayouts < ActiveRecord::Migration
  
  def self.up    
    create_table :email_layout do |t|
      t.string     :name
      t.text       :head
      t.text       :header
      t.text       :body
      t.text       :sidebar
      t.text       :products
      t.text       :footer      
      t.timestamps
    end
  end

  def self.down
    drop_table :email_layouts
  end

end