//
//  TableViewController.swift
//  Star Wars
//
//  Created by Dharmit Mahendra on 1/5/2016.
//  Copyright © 2019 Dharmit Mahendra. All rights reserved.
//

import UIKit

struct Results:Decodable{
    var count:Int
    var results:[Movie]
}

struct Movie:Decodable{
    var title:String
    var director:String
    var producer:String
    var release_date: String
    var characters: [String]
}

struct Character:Decodable{
    var name:String
}

class TableViewController: UITableViewController {

    
    
    var cnt = 0
    var index = 0
    var Movies: Results = Results.init(count: 0, results: [Movie.init(title: "", director: "", producer: "", release_date: "", characters: [""])])
    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Fetching data from API and setting it to a Movies object of type Results
        let url = "https://swapi.co/api/films"
        guard let urlObj = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: urlObj) {(data, response, error) in
            do{
                var tempMovies = try JSONDecoder().decode(Results.self, from: data!)
                self.cnt = tempMovies.count
                self.Movies = tempMovies
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch{
                print("Couldn't fetch data")
            }
            }.resume()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      
        return self.cnt
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath)
        Movies.results = Movies.results.sorted(by: {$0.release_date > $1.release_date} )
        
        cell.textLabel?.text = Movies.results[i].title
        i += 1
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //OnClick of each cell the next VC is opened with information based on the chosen cell
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath)
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "mainVC") as! ViewController
    
    
        nextVC.Movies = self.Movies
        nextVC.index = indexPath.row
        self.present(nextVC, animated: true, completion: nil)
        
    }
    
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
