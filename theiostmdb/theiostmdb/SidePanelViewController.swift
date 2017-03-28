//
//  SidePanelViewController.swift
//  theiostmdb
//
//  Created by bbva on 23/3/17.
//
//

import UIKit

@objc
protocol SidePanelViewControllerDelegate {
    func optionSelected(vc: UIViewController)
}

class SidePanelViewController: UIViewController {

    var delegate: SidePanelViewControllerDelegate?
    let optionArray = [String](arrayLiteral: "Discover","Search")
    
    @IBOutlet weak var optionsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        optionsTable.delegate = self
        optionsTable.dataSource = self
        optionsTable.register(UINib.init(nibName: "OptionCell", bundle: nil), forCellReuseIdentifier: "optionCell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SidePanelViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 2
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as! OptionCell
        cell.titleforIndex(title: self.optionArray[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height/2.0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            delegate?.optionSelected(vc: ViewController())
        default:
            return
        }
    }
}

class OptionCell: UITableViewCell{
    
    @IBOutlet weak var optionLabel: UILabel!
    
    
    func titleforIndex(title: String){
        self.optionLabel.text = title
    }
}
