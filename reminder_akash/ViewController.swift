import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var viewNoData: UIView!
    
    @IBOutlet weak var viewCreateNewReminder: UIView!
    
    @IBOutlet weak var tableView: UITableView!
        
    @IBOutlet weak var viewNodataMessage: UIView!
    
    @IBAction func btnModify(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var viewTableContainer: UIView!
    
    @IBAction func btnCreateNewReminder(_ sender: UIButton) {
        let inputVC = self.storyboard?.instantiateViewController(withIdentifier: "InputScreenViewController") as! InputScreenViewController;
                
        self.navigationController?.pushViewController(inputVC, animated: true);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        viewNodataMessage?.layer.cornerRadius = 15
        viewNodataMessage?.layer.masksToBounds = true
        viewCreateNewReminder?.layer.cornerRadius = 15
        viewCreateNewReminder?.layer.masksToBounds = true
    
        if(ReminderManager.shared.reminders.isEmpty){
            viewNoData.isHidden = false
            viewTableContainer.isHidden = true
        } else {
            viewNoData.isHidden = true
            viewTableContainer.isHidden = false
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReminderManager.shared.reminders.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        cell.contentView.viewWithTag(1)?.layer.cornerRadius = 20
        let reminder = ReminderManager.shared.reminders[indexPath.row]
        if let dateLabel = cell.contentView.viewWithTag(2) as? UILabel {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy HH:mm" 
            let formattedDate = dateFormatter.string(from: reminder.dateTime)
            dateLabel.text = formattedDate
        }
        if let label = cell.contentView.viewWithTag(4) as? UILabel {
            label.text = reminder.title
        }
        return cell
    }


}

