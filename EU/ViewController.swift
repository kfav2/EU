//
//  ViewController.swift
//  EU
//
//  Created by Korlin Favara on 1/1/22.
//

import UIKit

class ViewController: UIViewController {
    var EUArray = ["Austria",
                   "Belgium",
                   "Bulgaria",
                   "Croatia",
                   "Cyprus",
                   "Czechia",
                   "Denmark",
                   "Estonia",
                   "Finland",
                   "France",
                   "Germany",
                   "Greece",
                   "Hungary",
                   "Ireland",
                   "Italy",
                   "Latvia",
                   "Lithuania",
                   "Luxembourg",
                   "Malta",
                   "Netherlands",
                   "Poland",
                   "Portugal",
                   "Romania",
                   "Slovakia",
                   "Slovenia",
                   "Spain",
                   "Sweden",
                   "United Kingdom"]

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowDetail" {
        let destination = segue.destination as! DetailViewController
        let selectedIndexPath = tableView.indexPathForSelectedRow!
        destination.countryName = EUArray[selectedIndexPath.row]
    } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true )
        }
    }
}
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue ) {
        let source = segue.source as! DetailViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            EUArray[selectedIndexPath.row] = source.countryName
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: EUArray.count, section: 0)
            EUArray.append(source.countryName)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
    }
    
    // to enable editting tableView
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing { // if you are editting then the button reads "Done"
            tableView.setEditing(false, animated: true)
            sender.title = "Edit" // change button title to "Edit"
            addButton.isEnabled = true
        } else {
            tableView.setEditing(true, animated: true)
            sender.title = "Done" // change button title to "Edit"
            addButton.isEnabled = false
        }
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // how many cells are in UITable, returns Int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        EUArray.count
    }
    
    // formatting cells so that they are "re-used", iOS only uses a defined amount of cells on a page. e.g. if table has 1000 elements, when you scroll the cells move and are reused
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = EUArray[indexPath.row]
        return cell
    }
    
    // for deleting a row options while editing tableView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            EUArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // for moving a row
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = EUArray[sourceIndexPath.row]
        EUArray.remove(at: sourceIndexPath.row)
        EUArray.insert(itemToMove, at: destinationIndexPath.row)
    }
}
