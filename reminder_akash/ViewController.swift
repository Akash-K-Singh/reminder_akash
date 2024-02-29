import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var viewNoData: UIView!
    
    @IBOutlet weak var viewCreateNewReminder: UIView!
    
    @IBOutlet weak var tableView: UITableView!
        
    @IBOutlet weak var viewNodataMessage: UIView!
    
    var buttonTapAction: (() -> Void)?
    
    @IBAction func btnModify(_ sender: UIButton) {
        if let action = buttonTapAction {
            action()
        }
    }
    
    @IBOutlet weak var viewTableContainer: UIView!
    
    @IBAction func btnCreateNewReminder(_ sender: UIButton) {
        let inputVC = self.storyboard?.instantiateViewController(withIdentifier: "InputScreenViewController") as! InputScreenViewController;
        inputVC.data = -1;
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
        cell.selectionStyle = .none
        
        // Find the button in the cell using the tag (assuming the tag is set to 10)
        if let button = cell.contentView.viewWithTag(10) as? UIButton {
            // Assign an action to the button
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            // Set a tag on the button to identify which row it belongs to
            button.tag = indexPath.row
        }
        
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
    
    func showAlert(for indexPath: IndexPath) {
        // Create UIAlertController
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Add an action (button) to delete
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            // Call function to handle delete action
            self?.deleteActionHandler(for: indexPath)
        }
        alertController.addAction(deleteAction)
        
        // Add an action (button) to edit
        let editAction = UIAlertAction(title: "Edit", style: .default) { [weak self] _ in
            // Call function to handle edit action
            self?.editActionHandler(for: indexPath)
        }
        alertController.addAction(editAction)
        
        // Add a cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present the alert controller
        self.present(alertController, animated: true, completion: nil)
    }

    @objc func buttonTapped(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        showAlert(for: indexPath)
    }
    
    func deleteActionHandler(for indexPath: IndexPath) {
        ReminderManager.shared.reminders.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        if(ReminderManager.shared.reminders.isEmpty){
            viewNoData.isHidden = false
            viewTableContainer.isHidden = true
        } else {
            viewNoData.isHidden = true
            viewTableContainer.isHidden = false
        }
    }
    
    func editActionHandler(for indexPath: IndexPath) {
        let inputVC = self.storyboard?.instantiateViewController(withIdentifier: "InputScreenViewController") as! InputScreenViewController
        inputVC.data = indexPath.row
        self.navigationController?.pushViewController(inputVC, animated: true)
    }
}

