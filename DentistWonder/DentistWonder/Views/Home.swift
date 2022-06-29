//
//  Home.swift
//  DentistWonder
//
//  Created by Mac on 29.06.2022.
//

import SwiftUI

struct Home: View {
    @StateObject var viewModel: AppointViewModel = .init()
    @Namespace var animation
    @FetchRequest(entity: Appointment.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Appointment.date, ascending: false)], predicate: nil, animation: .easeInOut) var
                  appointments: FetchedResults<Appointment>
    
    
    @State var showSidebar: Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Hoşgeldiniz!").bold()
                    Text("Randevularınızı sizin için listeledik.").font(.title2.bold())
                }.padding()
                    .frame(maxWidth: .infinity, alignment: .leading).background(Color.white.opacity(0.7)).cornerRadius(8)
                
                customSegmentedBar()
                    .padding(.top, 8)
            }
            .overlay(alignment: .topTrailing) {
                Image("dentlove").padding()
            }
            .padding()
        }
        .background(Color.blue.opacity(0.22))
        .overlay(alignment: .bottomTrailing) {
            Button {
                viewModel.openNewAppointment.toggle()
            } label: {
                Label {
                    
                } icon: {
                    Image("plus")
                }

            }.shadow(color: .black.opacity(0.3), radius: 50, x: 0, y: 0.5)
            .padding()
        }
        .fullScreenCover(isPresented: $viewModel.openNewAppointment) {
            viewModel.resetAppointmentData()
        } content: {
            AddNewAppoint().environmentObject(viewModel)
        }

    }
    
    @ViewBuilder func customSegmentedBar()-> some View {
        let tabs = ["Bugün", "Bu Hafta", "Bitmiş"]
        
        HStack(spacing: 10) {
            ForEach(tabs, id: \.self) { tab in
                Text(tab).font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(viewModel.currentTab == tab ? .white : .black)
                    .padding(.vertical)
                    .frame(maxWidth:.infinity).background{
                        
                        if viewModel.currentTab == tab {
                            Capsule()
                                .fill(Color(red: 51/255, green: 179/255, blue: 195/255))
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }.contentShape(Capsule())
                    .onTapGesture {
                        withAnimation{ viewModel.currentTab = tab}
                    }
                
            }
            
        }
        AppointView()
    }
    
    @ViewBuilder func AppointView()-> some View {
        LazyVStack(spacing:20) {
            ForEach(appointments) { appoint in
                AppointRowView(appoint: appoint)
            }
        }
    }
    
    @ViewBuilder func AppointRowView(appoint: Appointment)-> some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(appoint.type ?? "")
                    .font(.callout)
                    .padding(.vertical,5)
                    .padding(.horizontal)
                    .background{
                        Capsule()
                            .fill(.blue.opacity(0.3))
                    }
                
                Spacer()
                
            }
            
            Text(appoint.title ?? "")
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding()
            
            HStack(alignment: .bottom, spacing: 0) {
                VStack(alignment: .leading, spacing: 20) {
                    Label {
                        Text((appoint.date ?? Date()).formatted(date: .long, time: .shortened))
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .font(.callout)
                    
                    Label {
                        Text((appoint.date ?? Date()).formatted(date: .omitted, time: .shortened))
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .font(.callout)

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        appoint.managedObjectContext?.delete(appoint)
                        try? appoint.managedObjectContext?.save()
                    } label: {
                        Image(systemName: "minus.circle")
                            .font(.title2).foregroundColor(.white)
                    }

                }

                
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background{
            RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Color.blue.opacity(0.3))
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
