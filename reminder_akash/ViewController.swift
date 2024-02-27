import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewNoData: UIView!
    
    @IBOutlet weak var viewCreateNewReminder: UIView!
    
    @IBAction func btnCreateNewReminder(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewNoData?.layer.cornerRadius = 15
        viewNoData?.layer.masksToBounds = true
        viewCreateNewReminder?.layer.cornerRadius = 15
        viewCreateNewReminder?.layer.masksToBounds = true
    }


}

