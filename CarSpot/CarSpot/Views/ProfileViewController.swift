//
// Advanced iOS - MADS4005
// CarSpot
//
// Group 7
// Brian Domingo - 101330689
// Daryl Dyck - 101338429
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addSubSwiftUIView(swiftUIView: SignUpSwiftUIView())
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
