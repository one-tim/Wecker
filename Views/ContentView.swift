import SwiftUI

struct ContentView: View {
    @StateObject private var alarmManager = AlarmManager()
    @State private var selectedTime = Date()
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Mein Wecker")
                .font(.largeTitle)
                .bold()
            
            // macOS-kompatibler DatePicker (.graphical zeigt eine analoge Uhr, .field ein Eingabefeld)
            DatePicker("Weckzeit", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(.graphical)
                .labelsHidden()
            
            HStack(spacing: 20) {
                Button(action: {
                    alarmManager.scheduleAlarm(for: selectedTime)
                    showAlert = true
                }) {
                    Text("Wecker stellen")
                        .bold()
                        .frame(width: 150, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain) // Verhindert den Standard-macOS-Button-Rahmen
                
                Button(action: {
                    alarmManager.cancelAllAlarms()
                }) {
                    Text("Alle löschen")
                        .bold()
                        .frame(width: 150, height: 40)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(30)
        // Gibt dem Mac-Fenster und der Preview eine saubere Größe
        .frame(minWidth: 400, minHeight: 350)
        .onAppear {
            alarmManager.requestPermission()
        }
        .alert("Erfolg", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Dein Wecker wurde gestellt.")
        }
    }
}

#Preview {
    ContentView()
}
