import SwiftUI

struct ContentView: View {
    @StateObject private var alarmManager = AlarmManager()
    @State private var selectedTime = Date()
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Mein Wecker")
                .font(.largeTitle)
                .bold()
            
            // Das Apple-Typische Rad zur Zeiteinstellung
            DatePicker("Weckzeit", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            
            HStack(spacing: 20) {
                // Button zum Wecker stellen
                Button(action: {
                    alarmManager.scheduleAlarm(for: selectedTime)
                    showAlert = true
                }) {
                    Text("Wecker stellen")
                        .bold()
                        .frame(width: 150, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // Button zum Wecker löschen
                Button(action: {
                    alarmManager.cancelAllAlarms()
                }) {
                    Text("Alle löschen")
                        .bold()
                        .frame(width: 150, height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        // Fragt beim Starten der Ansicht direkt nach der Berechtigung
        .onAppear {
            alarmManager.requestPermission()
        }
        // Zeigt ein kurzes Popup, wenn der Wecker gestellt wurde
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Erfolg"),
                message: Text("Dein Wecker wurde gestellt."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    ContentView()
}
