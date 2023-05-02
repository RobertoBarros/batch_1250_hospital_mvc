require_relative '../models/appointment'

class AppointmentRepository
  def initialize(csv_file, patient_repository, doctor_repository)
    @csv_file = csv_file
    @patient_repository = patient_repository
    @doctor_repository = doctor_repository
    @appointments = []
    load_csv if File.exist?(@csv_file)
    @next_id = @appointments.empty? ? 1 : @appointments.last.id + 1
  end

  def add(appointment)
    appointment.id = @next_id
    @next_id += 1
    @appointments << appointment
    save_csv
  end

  def find(id)
    @appointments.select { |appointment| appointment.id == id }.first
  end

  def all
    @appointments
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|

      patient_id = row[:patient_id].to_i
      patient = @patient_repository.find(patient_id)

      doctor_id = row[:doctor_id].to_i
      doctor = @doctor_repository.find(doctor_id)


      appointment = Appointment.new(id: row[:id].to_i, patient: patient, doctor: doctor, date: row[:date])

      @appointments << appointment
    end
  end

  def save_csv
    CSV.open(@csv_file, 'wb', headers: :first_row, header_converters: :symbol) do |file|
      file << %i[id patient_id doctor_id date] # CSV HEADER

      @appointments.each do |appointment|
        file << [appointment.id, appointment.patient.id, appointment.doctor.id, appointment.date]
      end
    end
  end
end
