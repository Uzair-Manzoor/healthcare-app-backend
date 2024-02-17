class Api::V1::AppointmentsController < ApplicationController
  before_action :find_doctor, only: %i[destroy create]

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
    @appointment = Appointment.find_by(id: params[:id])

    if @appointment.nil?
      render json: { error: 'Appointment not found' }, status: :not_found
    elsif @appointment.destroy
      render json: { message: 'Appointment deleted successfully' }, status: :ok
    else
      render json: { error: 'Failed to delete appointment' }, status: :unprocessable_entity
    end
  end

  private

  def find_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end

  def set_appointment_params
    params.require(:appointment).permit(:date, :city, :reason, :doctor_id)
  end
end
