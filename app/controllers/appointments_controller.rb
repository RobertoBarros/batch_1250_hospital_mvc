require_relative '../views/appointments_view'

class AppointmentsController

  def initialize(appointment_repository, patient_repository, doctor_repository)
    @appointment_repository = appointment_repository
    @patient_repository = patient_repository
    @doctor_repository = doctor_repository

    @view = AppointmentsView.new
    @patients_view = PatientsView.new
    @doctors_view = DoctorsView.new
  end

  def create
    patients = @patient_repository.all
    @patients_view.list(patients)
    index = @patients_view.ask_index
    patient = patients[index]

    doctors = @doctor_repository.all
    @doctors_view.list(doctors)
    index = @doctors_view.ask_index
    doctor = doctors[index]

    date = @view.ask_date

    appointment = Appointment.new(patient: patient, doctor: doctor, date: date)

    @appointment_repository.add(appointment)
  end

  def list
    appointments = @appointment_repository.all
    @view.list(appointments)
  end
end
