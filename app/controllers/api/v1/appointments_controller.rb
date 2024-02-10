class Api::V1::AppointmentsController < ApplicationController
  before_action :find_doctor

  # Action for the appointments to a specific doctor for the user
  def index
    @appointments = Appointment.all
    render json: { appointments: @appointments }, each_serializer: AppointmentSerializer, status: :ok
  end

  # Action to create a new apointment
  def create
    @appointment = @doctor.appointments.build(set_appointment_params)
    @appointment.user = current_user

    if @appointment.save!
      render json: { appointment: AppointmentSerializer.new(@appointment) }, status: :created
    else
      render json: @appointment.errors, status: :unprocessable_entities
    end
  end

  def destroy
    @apointment = Appointment.find(params[:id])
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
