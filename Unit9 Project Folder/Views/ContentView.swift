//
//  ContentView.swift
//  Unit9 Project Folder
//
//  Created by Joseph Heydorn on 1/9/20.
//  Copyright © 2020 Joseph Heydorn. All rights reserved.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Reminder.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Reminder.reminderText, ascending: false)]) var reminders: FetchedResults<Reminder>
    
    @State var showReminderDetailView = false
    @State var showNewReminderView = false
    
    let notificationManager = NotificationManager()

    var body: some View {
        NavigationView {
            List {
                ForEach(reminders, id: \.reminderText) { reminder in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(reminder.reminderText)")
                                    .font(.headline)
                                Text("Date: \(reminder.date) - Location: \(reminder.locationLat)")
                                    .font(.subheadline)
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        self.managedObjectContext.delete(self.reminders[index])
                        try! self.managedObjectContext.save()
                    }
                }
            }
            
            .sheet(isPresented: $showNewReminderView) {
                NewReminderView().environment(\.managedObjectContext, self.managedObjectContext)

            }
                
        .navigationBarTitle("Reminders")
            .navigationBarItems(trailing: Button(action: {
                self.showNewReminderView = true
            }, label: {
                Image(systemName: "plus.circle")
                .resizable()
                    .frame(width: 32, height: 32, alignment: .center)
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
