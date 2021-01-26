//
//  Advanced iOS - MADS4005
//  CarSpot
//
//  Group 7
//  Brian Domingo - 101330689
//  Daryl Dyck - 101338429
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
    var ticketList: [ParkingTicket] = [ParkingTicket]()

    @IBOutlet weak var tableView: UITableView!
    var noTicketsLabel: UILabel?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
    }

    // when view loads - putting here so when user comes back to this page, it re-loads
    override func viewDidAppear(_ animated: Bool)
    {
        // load tickets from coreData every time the view appears
        ticketList = ticketController.getAllTicketsForUser(email: UserDefaults.standard.string(forKey: Login.CURRENT_USER.rawValue)!)

        // update listView
        tableView.reloadData()

        // add label if no tickets in history
        if (ticketList.count == 0)
        {
            noTicketsLabel = UILabel(frame: CGRect(x: 0, y: self.view.center.y, width: 300, height: 100))
            noTicketsLabel?.textAlignment = .center
            noTicketsLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
            noTicketsLabel?.textColor = UIColor(named: "primary")
            noTicketsLabel?.numberOfLines = 0
            noTicketsLabel?.text = "It does not appear you currently have any parking tickets."
            noTicketsLabel?.lineBreakMode = .byWordWrapping
            noTicketsLabel?.center = self.view.center
            view.addSubview(noTicketsLabel!)
        }
        else
        {
            noTicketsLabel?.isHidden = true
        }
    }

    // row count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ticketList.count
    }

    // load cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticketCell") as! TicketCell
        cell.loadCell(ticket: ticketList[indexPath.row])
        return cell
    }

    // on click cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        ticket = ticketList[indexPath.item]
        self.indexPath = indexPath
        self.reloadTicket = true
        performSegue(withIdentifier: "ticketDetailsSegua", sender: nil)
    }

    // send data to ticket details page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "ticketDetailsSegua")
        {
            let detailsScreen = segue.destination as! TicketDetailsViewController
            detailsScreen.ticket = self.ticket!
        }
    }
}
