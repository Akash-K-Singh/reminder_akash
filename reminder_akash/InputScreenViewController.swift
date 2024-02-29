import UIKit

class InputScreenViewController: UIViewController, UITextFieldDelegate {
    
    var data: Int?

    @IBOutlet weak var txtWhere: UITextField!
    
    @IBOutlet weak var txtWhat: UITextField!
    
    @IBOutlet weak var viewDateTimePicker: UIView!
    
    @IBAction func btnDone(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // Specify your desired date format
        let dateString = dateFormatter.string(from: dateTimePicker.date)
        txtWhat.text = dateString
        viewDateTimePicker.isHidden = true
    }
    
    @IBOutlet weak var viewCreate: UIView!
        
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    
    @IBAction func btnCreate(_ sender: UIButton) {
        // Check if both text fields have values
        guard let whereText = txtWhere.text else {
            return
        }
        
        // Create a Reminder object using the input values
        let newReminder = Reminder(title: whereText, dateTime: dateTimePicker.date)
        
        if(data == -1){
            ReminderManager.shared.reminders.append(newReminder)
        } else {
            ReminderManager.shared.reminders[data!] = newReminder
        }
        
        if let tableViewController = navigationController?.viewControllers.first as? ViewController {
            tableViewController.tableView.reloadData()
            tableViewController.viewNoData.isHidden = true
            tableViewController.viewTableContainer.isHidden = false
        }
        
        self.navigationController?.popViewController(animated: true);
    }
    
    

    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewDateTimePicker.isHidden = true
        
        txtWhat.delegate = self
        
        navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        
        let paddingViewWhere = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txtWhere.frame.size.height))
        
        let paddingViewWhat = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txtWhat.frame.size.height))
        
        viewDateTimePicker.layer.cornerRadius = 15
        viewDateTimePicker?.layer.masksToBounds = true
        viewCreate?.layer.cornerRadius = 15
        viewCreate?.layer.masksToBounds = true
        
        txtWhere?.layer.cornerRadius = 15
        txtWhere?.layer.masksToBounds = true
        txtWhere?.leftView = paddingViewWhere
        txtWhere?.leftViewMode = .always
        txtWhere?.attributedPlaceholder = NSAttributedString(string: "Where to?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        txtWhat?.layer.cornerRadius = 15
        txtWhat?.layer.masksToBounds = true
        txtWhat?.leftView = paddingViewWhat
        txtWhat?.leftViewMode = .always
        txtWhat?.attributedPlaceholder = NSAttributedString(string: "What date and time?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           if textField == txtWhat {
               viewDateTimePicker.isHidden = false
           }
       }
}
