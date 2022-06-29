//
//  TaskViewModel.swift
//  DentistWonder
//
//  Created by Mac on 29.06.2022.
//

import SwiftUI
import CoreData

class AppointViewModel: ObservableObject {
    @Published var currentTab: String = "Bugün"
    @Published var openNewAppointment: Bool = false
    @Published var appointTitle: String = ""
    @Published var appointkDate: Date = Date()
    @Published var appointType: String = "Kontrol"
    @Published var showDataPicker: Bool = false
    @Published var editAppoint: Appointment?
    
    func addAppointMent(context: NSManagedObjectContext) -> Bool {
        let appointment = Appointment(context: context)
        appointment.title = appointTitle
        appointment.date = appointkDate
        appointment.type = appointType
        appointment.isCompleted = false
        
        if let _ = try? context.save() {
            return true
        }
        return false
        
    }
    
    func resetAppointmentData() {
        appointType = "Kontrol"
        appointTitle = ""
        appointkDate = Date()
    }
    
}


