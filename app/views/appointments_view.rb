class AppointmentsView

  def ask_date
    puts "Enter appointment date (yyyy-mm-dd):"
    gets.chomp
  end


  def list(appointments)
    puts 'Appointments List'
    puts '-' * 30

    appointments.each_with_index do |appointment, index|
      puts "#{index + 1} - Doctor: #{appointment.doctor.name} - Patient: #{appointment.patient.name} - Date: #{appointment.date}"
    end

    puts '-' * 30
  end
end
