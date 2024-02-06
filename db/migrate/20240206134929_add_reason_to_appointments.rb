class AddReasonToAppointments < ActiveRecord::Migration[7.1]
  def change
    add_column :appointments, :reason, :text
  end
end
