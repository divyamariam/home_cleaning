class SetDefaultValue < ActiveRecord::Migration
  def change
    change_column :teams, :team_lead, :integer, default: 0
  end
end
