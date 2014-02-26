class AddDetailsToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :area_code, :string
    add_column :events, :team_lead, :integer
    add_column :events, :employee_name, :integer
    add_column :events, :home_details, :text
  end
end
