class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :doctor_id, :date, :reason, :city
end
