//
//  CharsTableViewController.swift
//  Star Wars
//
//  Created by Dharmit Mahendra on 1/5/2016.
//  Copyright © 2019 Dharmit Mahendra. All rights reserved.
//

import UIKit

class CharsTableViewController: UITableViewController {

    var index = 0
    var j = 0
    var i = 0
    
    //Movies object which is of type Results struct
    var Movies: Results = Results.init(count: 0, results: [Movie.init(title: "", director: "", producer: "", release_date: "", characters: [""])])
    var chars = Character.init(name: "")
    
    //Creating a cache object
    var cache = NSCache<AnyObject, AnyObject>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Movies.results[index].characters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charCells", for: indexPath)
        //loop goes through all the stored URL's and fetches the "name" into chars object
        while(j < Movies.results[index].characters.count){
            guard let urlObj = URL(string: Movies.results[index].characters[j]) else {exit(1)}
            
            URLSession.shared.dataTask(with: urlObj) {(data, response, error) in
                do{
                    self.chars = (try JSONDecoder().decode(Character.self, from: data!))
                    //storing the name in cache with key as the loop itr
                    self.cache.setObject(self.chars.name as AnyObject, forKey: self.j as AnyObject)
 

                    DispatchQueue.main.async {
                        //setting the value for cell based on key
                        cell.detailTextLabel?.text = (self.cache.object(forKey: self.j as AnyObject)! as! String)
                        tableView.reloadData()
                    }
                }catch{
                    print("Couldn't fetch data")
                }
                }.resume()
            
            j += 1
        }
        
     
        return cell
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
