//
//  ReminderDetailView.swift
//  Unit9 Project Folder
//
//  Created by Joseph Heydorn on 1/9/20.
//  Copyright © 2020 Joseph Heydorn. All rights reserved.
//

import SwiftUI
import CoreLocation
import MapKit

struct ReminderDetailView: View {
    let reminder = Reminder()
    

    var body: some View {
        NavigationView {
            MyMap()
                .edgesIgnoringSafeArea(.all)
        }
    }
}


struct ReminderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderDetailView()
    }
}
