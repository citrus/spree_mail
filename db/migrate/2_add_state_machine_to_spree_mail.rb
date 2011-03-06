class AddStateMachineToSpreeMail < ActiveRecord::Migration
  
  def self.up
    add_column :emails, :state, :string, :default => "layout"
    add_column :emails, :sent_at, :datetime
  end

  def self.down
    remove_column :emails, :state
    remove_column :emails, :sent_at
  end

end