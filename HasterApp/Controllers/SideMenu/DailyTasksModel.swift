//
//  DailyTasksModel.swift
//  HasterApp
//
//  Created by Aakif Nadeem on 27/08/2023.
//

import Foundation

struct DailyTaskModel {
    var leadPainter = ""
    var date: String = ""
    var projectName = ""
    var jobNumber = ""
    var taskCompleted = ""
    var safetyItemObj: [SafetyItems] = [
        SafetyItems(title: "Personal Protective Equipment", options: [
            SafetyItemsOptions(description: "Safety vest", selection: nil),
            SafetyItemsOptions(description: "Eye protection", selection: nil),
            SafetyItemsOptions(description: "Hearing protection", selection: nil),
            SafetyItemsOptions(description: "Hand protection", selection: nil),
            SafetyItemsOptions(description: "Respirator", selection: nil),
        ]),
        SafetyItems(title: "Safety Equipment", options: [
            SafetyItemsOptions(description: "First aid kit onsite", selection: nil),
            SafetyItemsOptions(description: "Fire extinguisher", selection: nil),
            SafetyItemsOptions(description: "SDS sheet onsite/on app", selection: nil)
        ]),
        SafetyItems(title: "Fall Protection", options: [
            SafetyItemsOptions(description: "Harness lanyard inspection", selection: nil),
            SafetyItemsOptions(description: "Barricade/Warning tape in place", selection: nil),
            SafetyItemsOptions(description: "Guardrails in place", selection: nil),
            SafetyItemsOptions(description: "Safety net", selection: nil)
        ]),
        SafetyItems(title: "Ladders", options: [
            SafetyItemsOptions(description: "Daily inspection", selection: nil),
            SafetyItemsOptions(description: "Top edge 36° above landing", selection: nil),
            SafetyItemsOptions(description: "Ladder tied off", selection: nil)
        ]),
        SafetyItems(title: "Walking Working Surfaces", options: [
            SafetyItemsOptions(description: "Daily inspection of jobsite", selection: nil),
            SafetyItemsOptions(description: "Manholes/Floor opening covered/marked", selection: nil),
            SafetyItemsOptions(description: "Proper housekeeping", selection: nil)
        ]),
        SafetyItems(title: "Scaffolding", options: [
            SafetyItemsOptions(description: "Daily inspection by competent person", selection: nil),
            SafetyItemsOptions(description: "Gaurd rails in place", selection: nil),
            SafetyItemsOptions(description: "Scaffolding tied off above 21ft", selection: nil),
            SafetyItemsOptions(description: "Planking in good condition", selection: nil)
        ]),
        SafetyItems(title: "Electrical", options: [
            SafetyItemsOptions(description: "GFIC being used", selection: nil),
            SafetyItemsOptions(description: "Cord inspected for damage", selection: nil),
            SafetyItemsOptions(description: "Tool cords inspected", selection: nil)
        ]),
        SafetyItems(title: "Traffic Safety", options: [
            SafetyItemsOptions(description: "Reflective vest", selection: nil),
            SafetyItemsOptions(description: "Traffic cones in place", selection: nil),
            SafetyItemsOptions(description: "Barricades/Sign in place", selection: nil),
            SafetyItemsOptions(description: "Proper night illumination", selection: nil)
        ])
    ]
    
    var workTaskPerformaceList: SafetyItems = SafetyItems(title: "Work Task Performed Today", list: [""])
    var potentialHazardList: SafetyItems = SafetyItems(title: "Potential Hazards to be aware of", list: [""])
    var employeeSignatureList: SafetyItems = SafetyItems(title: "Employee signature that i understand my job task and proper safety precautions", list: [""])
    
    var incidentObj: [SafetyItemsOptions] = [SafetyItemsOptions(description: "Near misses or lessons learned reported by your crew or tiered subcontractors for the previous day(s)?"),
                                             SafetyItemsOptions(description: "Wher any incidents or accidents reported by your crew or tiered subcontractors for the previous day(s)?"),
                                             SafetyItemsOptions(description: "If yes to any question above, did you report it to your supervisor")
    ]
    
    init() { }
}

struct SafetyItems {
    var title: String
    var options: [SafetyItemsOptions] = []
    var list: [String] = []
}

struct SafetyItemsOptions {
    var description: String
    var selection: Int?
}

struct DailyTaskResponse: Codable
{
    var message: String?
}
