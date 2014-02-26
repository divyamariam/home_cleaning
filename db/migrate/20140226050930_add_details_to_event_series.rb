class AddDetailsToEventSeries < ActiveRecord::Migration
  def change
  	add_column :event_series, :area_code, :string
    add_column :event_series, :team_lead, :integer
    add_column :event_series, :employee_name, :integer
    add_column :event_series, :home_details, :text
  end
end
