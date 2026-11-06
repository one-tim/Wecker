import Foundation
import UserNotifications

class AlarmManager: ObservableObject {
    
    // Fragt den Nutzer beim ersten Start nach der Erlaubnis für Mitteilungen
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Berechtigung erteilt!")
            } else if let error = error {
                print("Fehler bei der Berechtigung: \(error.localizedDescription)")
            }
        }
    }
    
    // Plant den eigentlichen Wecker
    func scheduleAlarm(for time: Date) {
        let center = UNUserNotificationCenter.current()
        
        // 1. Inhalt des Weckers definieren
        let content = UNMutableNotificationContent()
        content.title = "Wecker"
        content.body = "Zeit aufzustehen!"
        content.sound = UNNotificationSound.default // Nutzt den Standard-Benachrichtigungston
        
        // 2. Uhrzeit aus dem Date-Objekt extrahieren
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        // 3. Trigger erstellen (Wann soll der Wecker klingeln?)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // 4. Anfrage erstellen und an iOS übergeben
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("Fehler beim Planen des Weckers: \(error.localizedDescription)")
            } else {
                print("Wecker erfolgreich gestellt für \(dateComponents.hour ?? 0):\(dateComponents.minute ?? 0) Uhr")
            }
        }
    }
    
    // Löscht alle ausstehenden Wecker
    func cancelAllAlarms() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("Alle Wecker gelöscht.")
    }
}

