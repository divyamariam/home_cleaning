class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :contact_info
      t.string :additional_info
      t.integer :pay_scale
      t.string :comments
      t.string :customer_feedback
      t.string :working_hours

      t.timestamps
    end
  end
end
