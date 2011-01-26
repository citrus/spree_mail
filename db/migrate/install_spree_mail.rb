class InstallSpreeMail < ActiveRecord::Migration
  
  def self.up
    
    create_table :subscribers do |t|
      t.string     :name
      t.string     :email
      t.timestamps
    end
    
    create_table :emails do |t|
      t.text       :to
      t.string     :subject
      t.text       :body
      t.text       :html
      t.timestamps
    end
    
  end

  def self.down
    drop_table :subscribers
    drop_table :emails
  end

end