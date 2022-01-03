//
//  ViewController.swift
//  EU
//
//  Created by Korlin Favara on 1/1/22.
//

import UIKit

class ViewController: UIViewController {
    
    var euCountries: [EUCountry] = []
    
    var  countryNames = ["Austria",
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
    
    var countryCapitals = ["Vienna",
                           "Brussels",
                           "Sofia",
                           "Zagreb",
                           "Nicosia",
                           "Prague",
                           "Copenhagen",
                           "Tallinn",
                           "Helsinki",
                           "Paris",
                           "Berlin",
                           "Athens",
                           "Budapest",
                           "Dublin",
                           "Rome",
                           "Riga",
                           "Vilnius",
                           "Luxembourg (city)",
                           "Valetta",
                           "Amsterdam",
                           "Warsaw",
                           "Lisbon",
                           "Bucharest",
                           "Bratislava",
                           "Ljubljana",
                           "Madrid",
                           "Stockholm",
                           "London"]
    
    var usesEuro = [true,
                    true,
                    false,
                    false,
                    true,
                    false,
                    false,
                    true,
                    true,
                    true,
                    true,
                    true,
                    false,
                    true,
                    true,
                    true,
                    true,
                    true,
                    true,
                    true,
                    false,
                    true,
                    false,
                    true,
                    true,
                    true,
                    false,
                    false]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        for index in 0..<countryNames.count {
            let newCountry = EUCountry(name: countryNames[index], capital: countryCapitals[index], euro: usesEuro[index])
            euCountries.append(newCountry)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! DetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.euCountry = euCountries[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true )
            }
        }
    }
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue ) {
        let source = segue.source as! DetailViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            euCountries[selectedIndexPath.row] = source.euCountry
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: euCountries.count, section: 0)
            euCountries.append(source.euCountry)
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
        euCountries.count
    }
    
    // formatting cells so that they are "re-used", iOS only uses a defined amount of cells on a page. e.g. if table has 1000 elements, when you scroll the cells move and are reused
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = euCountries[indexPath.row].name
        cell.detailTextLabel?.text = "Capital: \(euCountries[indexPath.row].capital)"
        return cell
    }
    
    // for deleting a row options while editing tableView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            euCountries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // for moving a row
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = euCountries[sourceIndexPath.row]
        euCountries.remove(at: sourceIndexPath.row)
        euCountries.insert(itemToMove, at: destinationIndexPath.row)
    }
}
