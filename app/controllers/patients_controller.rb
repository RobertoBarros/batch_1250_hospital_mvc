require_relative '../views/patients_view'

class PatientsController
  def initialize(patient_repository, room_repository)
    @patient_repository = patient_repository
    @room_repository = room_repository
    @view = PatientsView.new
    @rooms_view = RoomsView.new
  end

  def create
    name = @view.ask_name
    age = @view.ask_age
    patient = Patient.new(name: name, age: age)


    # Mostrar todos os quartos
    rooms = @room_repository.all
    @rooms_view.list(rooms)
    index = @rooms_view.ask_index
    room = rooms[index]

    room.add_patient(patient)

    @patient_repository.add(patient)


  end

  def list
    patients = @patient_repository.all
    @view.list(patients)
  end
end
