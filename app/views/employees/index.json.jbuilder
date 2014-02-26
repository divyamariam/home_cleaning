json.array!(@employees) do |employee|
  json.extract! employee, :id, :first_name, :last_name, :contact_info, :additional_info, :pay_scale, :comments, :customer_feedback, :working_hours
  json.url employee_url(employee, format: :json)
end
