class Api::V1::DoctorsController < ApplicationController
  before_action :set_doctor_params, only: [:create]

  def index
    @doctors = Doctor.all
    render json: { doctors: @doctors }, each_serializer: DoctorSerializer, status: :ok
  end

  def show
    @doctor = Doctor.find(params[:id])
    @doctor.user = current_user
    render json: { doctor: DoctorSerializer.new(@doctor) }, status: :ok
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
