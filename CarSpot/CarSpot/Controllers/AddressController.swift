//
//  Advanced iOS - MADS4005
//  CarSpot
//
//  Group 7
//  Brian Domingo - 101330689
//  Daryl Dyck - 101338429
//

import Foundation
import CoreData
import UIKit

class AddressController
{

    private var moc: NSManagedObjectContext
    let fetchRequest = NSFetchRequest<Address>(entityName: "Address")

    init() {
        self.moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    func insertAddress(id: UUID, lat: Double, lon: Double, streetAddress: String, city: String, country: String, isCurrentLocation: Bool) -> InsertStatus
    {
        do {
            let newAddress = NSEntityDescription.insertNewObject(forEntityName: "Address", into: moc) as! Address

            newAddress.id = id
            newAddress.lat = lat
            newAddress.lon = lon
            newAddress.streetAddress = streetAddress
            newAddress.city = city
            newAddress.country = country
            newAddress.isCurrentLocation = isCurrentLocation

            try moc.save()

            return InsertStatus.success

        }
        catch let error as NSError
        {
            print(#function, "Error occured during insert")
            return InsertStatus.failed
        }
    }

    func getAddressForTicket(id: UUID) -> Location
    {
        let fetchRequest = NSFetchRequest<Address>(entityName: "Address")

        //equivalent to a WHERE statement
        let predicate = NSPredicate(format: "id == %@", id.uuidString)
        fetchRequest.predicate = predicate

        do {
            let result = try moc.fetch(fetchRequest).first
            if result != nil
            {
             //   print(#function, "Matching address found wwith id: \(id)")

                let address = result as! Address

                let location: Location = Location(id: address.id!,
                                                  lat: address.lat,
                                                  lon: address.lon,
                                                  streetAddress: address.streetAddress!,
                                                  city: address.city!,
                                                  country: address.country!)

               // print(#function, "Address Found")
                return location
            }
        } catch let error {
            print(#function, error.localizedDescription)
        }

        print(#function, "No address found with \(id)")
        return Location()
    }

    //TODO
    //MARK: This is from my experiment to get firebase to work.
    //    @Published var profileList = [Profile]
    //    private let
    //
    //    let store:Firestore
    //
    //    init(database:Firestore) {
    //        self.store = database
    //    }
    //
    //    func insertProfile(profile:Profile) {
    //        do {
    //            _ = try self.store.collection
    //        } catch error as NSError {
    //            print(#function, "Error inserting new profile")
    //        }
    //    }

}
