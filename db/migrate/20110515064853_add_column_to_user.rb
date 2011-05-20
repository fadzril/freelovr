class AddColumnToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :website,      :string
    add_column :users, :twitter,      :string
    add_column :users, :scope,        :string
    add_column :users, :designation,  :string
    add_column :users, :recommended,  :string
    add_column :users, :availability, :string
    add_column :users, :skillset,     :text
    add_column :users, :other,        :text
    add_column :users, :level,        :integer
    add_column :users, :experience,   :integer
  end

  def self.down
    remove_column :users, :website
    remove_column :users, :scope
    remove_column :users, :twitter
    remove_column :users, :designation
    remove_column :users, :recommended
    remove_column :users, :availability
    remove_column :users, :skillset
    remove_column :users, :other
    remove_column :users, :level
    remove_column :users, :experience
  end
end