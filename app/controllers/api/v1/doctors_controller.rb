class Api::V1::DoctorsController < ApplicationController
  before_action :set_doctor_params

  def index
    @doctor = Doctor.all
    @doctor.user = current_user
  end

  def create
    puts "current user:#{current_user}"
    @doctor = Doctor.new(set_doctor_params)
    @doctor.user = current_user

    if @doctor.save
      render json: { doctor: DoctorSerializer.new(@doctor) }, status: :created
    else
      render json: { error: @doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_doctor_params
    params.require(:doctor).permit(:name, :bio, :specialization, :image_url)
  end
end
