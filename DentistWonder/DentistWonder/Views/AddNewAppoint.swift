//
//  AddNewAppoint.swift
//  DentistWonder
//
//  Created by Mac on 29.06.2022.
//

import SwiftUI

struct AddNewAppoint: View {
    @EnvironmentObject var viewModel: AppointViewModel
    @Namespace var animation
    @Environment(\.self) var env
    var body: some View {
        VStack(spacing:12) {
            Text("Randevu Ekle")
                .font(.title3.bold())
                .frame(maxWidth:.infinity)
                .overlay(alignment:.leading) {
                    Button {
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.black)
                    }

                }
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Randevu Başlığı")
                    .font(.caption).bold()
                    .foregroundColor(.black)
                    .padding(.top, 10)
                
                TextField("", text: $viewModel.appointTitle)
                    .padding(10)
                    .frame(maxWidth:.infinity)
                    
                    .background(.white.opacity(0.8)).cornerRadius(8).disableAutocorrection(true)
                

            }
            Divider()
            VStack(alignment: .leading, spacing: 12) {
                Text("Randevu Tarihi")
                    .font(.caption).bold()
                    .foregroundColor(.black)
                    .padding(.top, 10)
                
                Text(viewModel.appointkDate.formatted(date: .abbreviated, time: .omitted) + ", " + viewModel.appointkDate.formatted(date: .omitted, time: .shortened))
                    .padding()
                    .frame(maxWidth:.infinity)
                    
                    
                    .font(.callout)
                    .background(.white.opacity(0.8)).cornerRadius(8)
                    .overlay(alignment: .trailing) {
                        Button {
                            viewModel.showDataPicker.toggle()
                        } label: {
                            Image(systemName: "calendar")
                                .foregroundColor(.black)
                        }.padding()
                    }

            }
            Divider()
            
            let appointTypes: [String] = ["Kontrol", "Diş Çekimi", "Kanal Tedavisi", "Dolgu", "Diş Temizliği"]
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Randevu Operasyonu")
                    .font(.caption).bold().padding(.top, 10)
                
                HStack(spacing:12) {
                    ForEach(appointTypes, id: \.self) { type in
                       Text(type)
                            .font(.callout)
                            .frame(maxWidth:.infinity)
                            .background{
                                if viewModel.appointType == type {
                                    Capsule().strokeBorder(Color(red: 51/255, green: 179/255, blue: 195/255), lineWidth: 4).matchedGeometryEffect(id: "TYPE", in: animation).frame(width: 74, height: 60)
                                } else {
                                    
                                }
                            }.onTapGesture {
                                withAnimation{viewModel.appointType = type}
                            }
                    }
                }
            }
            Divider()
            
            Button {
                if viewModel.addAppointMent(context: env.managedObjectContext) {
                    env.dismiss()
                }
            } label: {
                Text("Kaydet")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color(red: 51/255, green: 179/255, blue: 195/255))
                    .cornerRadius(20)
            }
            .shadow(color: .white.opacity(0.5), radius: 50, x: 0, y: 0.5)
            .frame(maxHeight: .infinity, alignment:.bottom)
            
            .disabled(viewModel.appointTitle == "")
        }
        
        .frame(maxHeight:.infinity, alignment: .top)
        .padding()
        .background(Color.blue.opacity(0.22))
        .overlay{
            ZStack {
                if viewModel.showDataPicker {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            viewModel.showDataPicker = false
                        }
                    
                    DatePicker.init("", selection: $viewModel.appointkDate, in: Date.now...Date.distantFuture)
                        .labelsHidden()
                        .padding()
                        .datePickerStyle(.graphical)
                        .background(.white, in: RoundedRectangle(cornerRadius: 12, style: .continuous)).padding()
                }
                
            }
        
          
        }
    }
}

struct AddNewAppoint_Previews: PreviewProvider {
    static var previews: some View {
        AddNewAppoint().environmentObject(AppointViewModel())
    }
}
