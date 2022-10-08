//
//  SDSViewController.swift
//  HesterDecorating
//
//  Created by Usama Ali on 30/06/2021.
//

import UIKit
import SwiftyJSON

class SDSViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var sdsDocs : [SDSData] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupData()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupData(){
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        self.getSds()
    }
    
    func getSds(){
        self.startAnimating()
        NetworkManager.getSds(search: searchBar!.text!) { checkSds in
            self.stopsAnimating()
            if let sds = checkSds {
                self.sdsDocs = sds.data ?? []
                self.tableView.reloadData()
            }
            else{
            }
        }
    }

    @objc func handleExpandClose(button: UIButton) {
        print("Trying to expand and close section...")
        
        let section = button.tag
        let isExpanded = self.sdsDocs[section].isExpended
//        self.propViewModal.propertiesarr[section].isExpanded = !isExpanded
//        let indexPath = IndexPath(row: propViewModal.propertiesarr[section].baseUnits!.count, section: section)
        sdsDocs[section].isExpended = !isExpanded
        if isExpanded {
            tableView.reloadData()
        } else {
//            // button.setImage(UIImage.init(named: "upArrowImage"), for: .normal)
            tableView.reloadData()
        }
    }
}

extension SDSViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sdsDocs.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sdsDocs[section].isExpended {
            return sdsDocs[section].files?.count ?? 0
        }
        return 0
//        return sdsDocs[section].files?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let nameLbl = cell.contentView.viewWithTag(2) as? UITextView
        let imageCont = cell.contentView.viewWithTag(1) as? UIImageView
        
        nameLbl?.text = sdsDocs[indexPath.section].files?[indexPath.row].url
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView : PropertyHeaderView = .fromNib()
        headerView.titleLabel.text = sdsDocs[section].title
        headerView.ExpendButton.addTarget(self, action: #selector(self.handleExpandClose), for: .touchUpInside)
        headerView.ExpendButton.tag = section
        headerView.backgroundColor = UIColor.clear
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
}

extension SDSViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        getSds()
    }
}
