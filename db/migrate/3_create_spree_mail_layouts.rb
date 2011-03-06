class CreateSpreeMailLayouts < ActiveRecord::Migration
  
  def self.up    
    create_table :email_layouts do |t|
      t.string     :name
      t.text       :head
      t.text       :header
      t.text       :body
      t.text       :sidebar
      t.text       :products
      t.text       :footer      
      t.timestamps
    end
    add_column :emails, :layout, :string
  end

  def self.down
    drop_table :email_layouts
    remove_column :emails, :layout
  end

end