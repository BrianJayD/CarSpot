//
//  Advanced iOS - MADS4005
//  CarSpot
//
//  Group 7
//  Brian Domingo - 101330689
//  Daryl Dyck - 101338429
//

import UIKit

class TicketCell: UITableViewCell
{
    var ticket: ParkingTicket?
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var licensePlateLabel: UILabel!

    func loadCell(ticket: ParkingTicket)
    {
        self.ticket = ticket
        dateLabel.text = ticket.dateString
        hoursLabel.text = "\(ticket.noOfHours) hour(s)"
        addressLabel.text = ticket.location.streetAddress
        licensePlateLabel.text = ticket.licensePlate
    }


}
