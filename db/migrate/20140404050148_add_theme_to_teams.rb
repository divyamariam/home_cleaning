class AddThemeToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :theme, :string
  end
end
