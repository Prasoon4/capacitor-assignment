import Foundation
import Capacitor

@objc(DobDialog)
public class DobDialog: CAPPlugin {
    
    @objc func showDialog(_ call: CAPPluginCall) {
        
        guard
            let title = call.getString("title"),
            let message = call.getString("message"),
            let selectedDateStr = call.getString("selectedDate"),
            let maxDateStr = call.getString("maxDate"),
            let selectedDate = DateUtils.parseDate(selectedDateStr),
            let maxDate = DateUtils.parseDate(maxDateStr)
        else {
            return
        }
        
        DispatchQueue.main.async {
            
            self.showDobPickerDialog(viewController: self.bridge!.viewController!, title: title, message: message, selectedDate: selectedDate, maxDate: maxDate) { selectedDate in
                var result = JSObject()
                result["selectedDate"] = DateUtils.parseDate(selectedDate)
                call.resolve(result);
            }
        }
    }
    
    func showDobPickerDialog(viewController: UIViewController, title: String, message: String, selectedDate: Date, maxDate: Date, onSelect: @escaping (String) -> Void) {
        
        // Create a custom view controller
        let datePickerVC = UIViewController()
        datePickerVC.modalPresentationStyle = .overFullScreen
        datePickerVC.view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        datePickerVC.view.isUserInteractionEnabled = true
        
        // Container view
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.isUserInteractionEnabled = true
        
        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
        // Message Label
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(messageLabel)
        
        // UIDatePicker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.date = selectedDate
        datePicker.maximumDate = maxDate
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(datePicker)
        
        // OK Button
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.addAction(UIAction(handler: { _ in
            onSelect(DateUtils.parseDate(datePicker.date))
            datePickerVC.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(okButton)
        
        // Cancel Button
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addAction(UIAction(handler: { _ in
            datePickerVC.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(cancelButton)
        
        // Add container view to the datePickerVC
        datePickerVC.view.addSubview(containerView)
        
        // Set up constraints for container view and subviews
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: datePickerVC.view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: datePickerVC.view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            datePicker.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10),
            datePicker.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            okButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            okButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            cancelButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
        
        // Present the custom view controller
        viewController.present(datePickerVC, animated: true, completion: nil)
    }
}

