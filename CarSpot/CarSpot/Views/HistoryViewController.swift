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
    let profileController = ProfileController()
    let ticketController = TicketController()

    var ticket: ParkingTicket?
    var indexPath: IndexPath?
    var reloadTicket: Bool = false
    var ticketList: [ParkingTicket]?


    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        ticketList = ticketController.getAllTicketsForUser(email: UserDefaults.standard.string(forKey: Login.CURRENT_USER.rawValue)!)

        tableView.delegate = self
        tableView.dataSource = self
//           setupSwiftUIView()
    }

    override func viewDidAppear(_ animated: Bool)
    {
        ticketList = ticketController.getAllTicketsForUser(email: UserDefaults.standard.string(forKey: Login.CURRENT_USER.rawValue)!)
        print(#function, "Tickets in list: \(ticketList!.count)")
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ticketList!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticketCell") as! TicketCell
        cell.loadCell(ticket: ticketList![indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        ticket = ticketList![indexPath.item]
        self.indexPath = indexPath
        self.reloadTicket = true
        performSegue(withIdentifier: "ticketDetailsSegua", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "ticketDetailsSegua")
        {
            let detailsScreen = segue.destination as! TicketDetailsViewController
            detailsScreen.ticket = self.ticket!
//            detailsScreen.attractionPresenter = self.attractionPresenter!

        }
    }




    func setupSwiftUIView()
    {
        let hostController = UIHostingController(rootView: HistorySwiftUIView(ticketList: ticketList!))
        self.addChild(hostController)
        hostController.view.frame = self.view.frame
        self.view.addSubview(hostController.view)
        hostController.didMove(toParent: self)
    }

}
