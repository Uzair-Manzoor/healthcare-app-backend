class DoctorSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :bio, :specialization, :image_url
end
