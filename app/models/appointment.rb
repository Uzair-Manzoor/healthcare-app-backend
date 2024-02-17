class Appointment < ApplicationRecord
  validates :city, presence: true
  validates :date, presence: true
  validates :reason, presence: true
  belongs_to :user
  belongs_to :doctor
end
