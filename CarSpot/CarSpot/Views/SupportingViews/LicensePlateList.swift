//
// Advanced iOS - MADS4005
// CarSpot
//
// Group 7
// Brian Domingo - 101330689
// Daryl Dyck - 101338429
//

import SwiftUI

struct LicensePlateList: View {
    @State var plateNumbers:[PlateNumber]
    
    private func delete(with indexSet: IndexSet) {
        indexSet.forEach { plateNumbers.remove(at: $0) }
    }
    
    var body: some View {
        
        VStack {
            Text("Your License Plates")
                .font(.headline)
            
            List {
                ForEach(plateNumbers) { plateNumber in
                    HStack {
                        Spacer()
                        LicensePlateRow(plateNumber: plateNumber.plateNumber)
                        Spacer()
                    }
                }.onDelete(perform: delete)
            }
        }
        
        
    }
}

struct LicensePlateList_Previews: PreviewProvider {
    static var previews: some View {
        
        LicensePlateList(plateNumbers: [
                            PlateNumber(plateNumber: "BCA482", email: "b@b.com"),
                            PlateNumber(plateNumber: "SICKVET", email: "vet@vet.com")
        ])
    }
}
