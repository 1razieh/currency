

import UIKit

class ViewController: UIViewController {
    //MARK:OUTLET
    
    @IBOutlet weak var currencyView: UIStackView!
    @IBOutlet weak var currencySignLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var pickerFrom: UIPickerView!
    @IBOutlet weak var dateLbl: UILabel!
    
    //MARK:VARIABLE
    var currencyDic = [String:Double]() {
        didSet {
            DispatchQueue.main.async {
                self.pickerFrom.reloadAllComponents()
            }
        }
    }
    var lastUpdateDate = ""{
        didSet {
            DispatchQueue.main.async {
                self.dateLbl.text = self.lastUpdateDate
            }
        }
    }
     var currencyNameArray  = [String]()
     var currencyManager = CurrencyManager()
    
    //MARK:LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
       
        currencyView.layer.cornerRadius = 40
        pickerFrom.dataSource = self
        pickerFrom.delegate = self
        currencyManager.getCurrency { (currency) in
            if currency != nil  {
                self.currencyDic = currency!.rates
                self.lastUpdateDate = currency!.date
                
            }
            else {
                DispatchQueue.main.async {
                    self.displayAlert(title: "Error", message: "Please try later")
                }
                
            }
        }
       
    }
   
    
    func displayAlert(title:String ,message:String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
//MARK: PickerView
extension ViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currencyDic.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        currencyNameArray = Array(currencyDic.keys.sorted(by: <))
        return currencyNameArray[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        rateLbl.text = String (format: "%.3f", currencyDic[currencyNameArray[row]] ??  "")
        currencySignLbl.text = currencyNameArray[row]
    }
    
}




