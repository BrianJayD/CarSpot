//
//  HistoryViewController.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-18.
//

import UIKit
import SwiftUI

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var ticket: ParkingTicket?
    var indexPath: IndexPath?
    var reloadTicket: Bool = false

    let ticketList: [ParkingTicket] = [
        ParkingTicket(email: "user@emailaddress.com",
                      buildingCode: "12345",
                      noOfHours: 12,
                      licensePlate: "12AD78",
                      hostSuite: "1305",
                      location:
                          Location(lat: 43.6532,
                                   lon: -79.3832,
                                   streetAddress: "123 Carlton Street",
                                   city: "Toronto",
                                   country: "Canada")
        ),
        ParkingTicket(email: "user@emailaddress.com",
                      buildingCode: "789456",
                      noOfHours: 24,
                      licensePlate: "opghwe",
                      hostSuite: "827",
                      location:
                          Location(lat: 43.6532,
                                   lon: -79.3832,
                                   streetAddress: "95 Carlton Street",
                                   city: "Toronto",
                                   country: "Canada")
        )]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        //   setupSwiftUIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ticketList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticketCell") as! TicketCell
        cell.loadCell(ticket: ticketList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        ticket = ticketList[indexPath.item]
        self.indexPath = indexPath
        self.reloadTicket = true
        performSegue(withIdentifier: "ticketDetailsSegua", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "ticketDetailsSegua")
        {
            let detailsScreen = segue.destination as! TicketDetailsViewController
//            detailsScreen.attraction = self.attraction!
//            detailsScreen.attractionPresenter = self.attractionPresenter!

        }
    }




    func setupSwiftUIView()
    {
        let hostController = UIHostingController(rootView: TicketDetails(ticket: ticket!))
        self.addChild(hostController)
        hostController.view.frame = self.view.frame
        self.view.addSubview(hostController.view)
        hostController.didMove(toParent: self)
    }

}
