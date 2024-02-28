import Foundation
class ReminderManager {
  static let shared = ReminderManager()
    var reminders: [Reminder] = []
  private init() {}
}
