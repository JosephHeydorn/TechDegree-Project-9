//
//  NewReminderView.swift
//  Unit9 Project Folder
//
//  Created by Joseph Heydorn on 1/9/20.
//  Copyright © 2020 Joseph Heydorn. All rights reserved.
//

import SwiftUI
import CoreLocation

struct NewReminderView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var reminderEntry = ""
    @State private var includeLocation = false
    @State private var onEntry = true
    
    private var date = Date()
    private var dateFormatter = DateFormatter()
    
    private var coreLocation = LocationHandler()
    private var myMapView = MyMap()
    
    private var delegate: AddNotificationDelegate?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Map")) {
                    PinImage()
                        .offset(x: 150, y: 110)
                        .padding(.bottom, -200)
                    myMapView
                        .frame(height: 250, alignment: .center)
                        .padding(.top, -10)
                    
                }
                Section(header: Text("Reminder Entry")) {
                    TextField("Write Here", text: $reminderEntry)
                    .keyboardType(.default)
                    Toggle(isOn: $includeLocation) {
                    Text("Include Location")
                    }
                        Button(action: {
                            print("On Exit")
                            self.onEntry = false
                            
                        }) {
                            Text("On Exit")
                            
                        }
                        Button(action: {
                            print("On Entry")
                            self.onEntry = true
                        })  {
                            Text("On Entry")
                        }
                }
                Button(action: {
                    guard self.reminderEntry != "" else {return}
                    let newReminder = Reminder(context: self.managedObjectContext)
                    newReminder.reminderText = self.reminderEntry
                    self.dateFormatter.dateFormat = "MM-dd-yyy"
                    newReminder.date = self.dateFormatter.string(from: self.date)
                    if self.includeLocation == true {
                        print("Location Added")
                        DispatchQueue.main.async {
                            print(self.myMapView.mapView.centerCoordinate)
                            newReminder.locationLon = self.myMapView.mapView.centerCoordinate.longitude
                            newReminder.locationLat = self.myMapView.mapView.centerCoordinate.latitude
                            
                            //Call New Anotations delegate method
                            self.delegate?.addNotificationDelegate(didAddCoordinate: self.myMapView.mapView.centerCoordinate, radius: 2.0, reminderEntry: self.reminderEntry, onEntry: true, identifier: "Some Identifier")
                            
                            if self.onEntry == true {
                                newReminder.onEntry = true
                            } else {
                                newReminder.onEntry = false
                            }
                        }
                    }
                    do {
                        try self.managedObjectContext.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }) {
                    Text("Add Reminder")
                    
                }
            }
        .navigationBarTitle("Add New Reminder!")
        } .onAppear() {
            self.coreLocation.requestLocationOnce()
        }
    }
}

struct NewReminderView_Previews: PreviewProvider {
    static var previews: some View {
        NewReminderView()
    }
}


