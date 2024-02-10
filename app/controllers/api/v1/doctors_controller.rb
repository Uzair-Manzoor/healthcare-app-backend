class Api::V1::DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show]

  def index
    @doctors = Doctor.all
    @doctors.each { |doctor| doctor.user = current_user }
  end

  def show
    render json: { doctor: DoctorSerializer.new(@doctor) }
  end

  def create
    @doctor = Doctor.new(doctor_params)
    @doctor.user = current_user

    if @doctor.save
      render json: { doctor: DoctorSerializer.new(@doctor) }, status: :created
    else
      render json: { error: @doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(:name, :bio, :specialization, :image_url)
  end
end
