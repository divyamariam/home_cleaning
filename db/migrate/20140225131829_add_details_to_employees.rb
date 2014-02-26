class AddDetailsToEmployees < ActiveRecord::Migration
  def change
  	add_column :employees, :username, :string
    add_column :employees, :password, :string
    add_column :employees, :position, :integer, default: 0
  end
end
