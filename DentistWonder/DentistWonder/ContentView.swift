//
//  ContentView.swift
//  DentistWonder
//
//  Created by Mac on 29.06.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
  
    var body: some View {
        NavigationView {
            Home()
                .navigationTitle("DentistWonder🦷")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            
                        } label: {
                            Image("dentist")
                                .resizable().frame(width: 48, height: 48).cornerRadius(50)
                        }

                    }
                })
                .navigationBarTitleDisplayMode(.large)
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
