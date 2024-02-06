class Api::V1::AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_doctor
  # Action for the appointments to a specific doctor
  def index
    @appointments = @doctor.appointments
    @appointment.user = current_user
    render json: @appointments
  end

  # Action to create a new apointment
  def create
    @apointment = @doctor.appointments.build(set_appointment_params)
    @appointment.user = current_user

    if @apointment.save?
      render json: @apointment, status: :created
    else
      render json: @apointment.errors, status: :unprocessable_entities
    end
  end

  def destroy
    @apointment = Appointment.find(params[:apointment_id])
    @apointment.destroy
    render json: { message: 'Appointment deleted!' }
  end

  private

  def find_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end

  def set_appointment_params
    params.require(:appointment).permit(:date, :city, :reason)
  end
end
