//
// Advanced iOS - MADS4005
// CarSpot
//
// Group 7
// Brian Domingo - 101330689
// Daryl Dyck - 101338429
//

import SwiftUI
import CoreData

struct LicensePlatesSwiftUIView: View {
    @State private var tfAddPlate:String = ""
    
    @State var plateNumbers:[PlateNumber] = []
    @State private var isLogged:Bool = UserDefaults.standard.bool(forKey: Login.LOGGED_IN.rawValue)
    let currentUserEmail = UserDefaults.standard.string(forKey: Login.CURRENT_USER.rawValue)
    
    let licensePlateController = LicensePlateController()
    @State var plates:[PlateNumber] = []
    @State var removedPlates:[PlateNumber] = []
    
    @State var showAddError:Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    init() {
        UITableView.appearance().isScrollEnabled = true
        
        for p in plates {
            print("init(): \(p.plateNumber)")
        }
    }
    
    func loadPlates() {
        
        if(isLogged) {
            print("Your plates...")
        }
        plates = licensePlateController.getAllPlateNumbersForUser(email: currentUserEmail!)
        
        for p in plates {
            print("Loaded: \(p.plateNumber)")
        }
    }
    
    private func delete(with indexSet: IndexSet) {
        //plates.remove(atOffsets: indexSet)
        
        indexSet.forEach ({ index in
            removedPlates.append(plates[index])
            plates.remove(at: index)
        })
        
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("License Plates")) {
                    Text("Enter license plate:")
                    HStack {
                        
                        TextField("License Plate", text: $tfAddPlate)
                            .multilineTextAlignment(.center)
                        
                    }
                }
                
                //ONLY SHOW IF USER IS LOGGED IN
                
                Section {
                    Button(action: {
                        guard tfAddPlate != "" else {
                            print(#function, "Invalid plates, please try again.")
                            return
                        }
                        
                        if(tfAddPlate.count > 1 && tfAddPlate.count < 9 && tfAddPlate != "") {
                            let plateNumber = PlateNumber(plateNumber: tfAddPlate.uppercased())
                            
                            plates.append(PlateNumber(plateNumber: plateNumber.plateNumber))
                            
                            
                            print("NEW PLATE \(plateNumber.plateNumber)")
                            
                            licensePlateController.insertLicensePlate(email: currentUserEmail!, plateNumber: tfAddPlate.uppercased())
                            
                            for plate in plates {
                                print(plate.plateNumber)
                            }
                            
                            tfAddPlate = ""
                        } else {
                            self.showAddError = true
                        }
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Add new plate")
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color("textOnBackgroundSecondary"))
                            Spacer()
                        }
                    })
                    .padding()
                    .alert(isPresented: $showAddError) {
                        Alert(title: Text("Invalid License Plate"), message: Text("Invalid email. Must be between 2-8 characters long."), dismissButton: .default(Text("Dismiss")))
                    }
                }
                
                Section {
                    HStack{
                        Spacer()
                        Text("Your License Plates")
                            .font(.headline)
                        Spacer()
                    }
                    
                    List {
                        ForEach(plates) { plateNumber in
                            HStack {
                                Spacer()
                                LicensePlateRow(plateNumber: plateNumber.plateNumber)
                                Spacer()
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
            }.onAppear(perform: {
                loadPlates()
            })
            
            Button(action: {
                for plate in plates {
                    print("Ending with \(plate.plateNumber)")
                }
                
                for removed in removedPlates {
                    print("Removed: \(removed.plateNumber)")
                    licensePlateController.removeLicensePlate(plateNumber: removed.plateNumber)
                }

                plates.removeAll()
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Close")
                    .foregroundColor(Color("textOnBackground"))
            })
            .padding()
        }
    }
}


struct LicensePlatesSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LicensePlatesSwiftUIView()
    }
}

