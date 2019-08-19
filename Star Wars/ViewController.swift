//
//  ViewController.swift
//  Star Wars
//
//  Created by Dharmit Mahendra on 1/5/2016.
//  Copyright © 2019 Dharmit Mahendra. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var directorLabel: UILabel!
    @IBOutlet var producerLabel: UILabel!
    @IBOutlet var RDLabel: UILabel!
    @IBOutlet var movImg: UIImageView!
    
   
    var index = 0
   var Movies: Results = Results.init(count: 0, results: [Movie.init(title: "", director: "", producer: "", release_date: "", characters: [""])])
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Showing values that was passed on by the previous VC
        navBar.topItem?.title = Movies.results[index].title
        directorLabel.text = Movies.results[index].director
        producerLabel.text = Movies.results[index].producer
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:Movies.results[index].release_date)!
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        RDLabel.text = "\(String(describing: components.year!))"
        
        /*
        var chars = [Character.init(name: "")]
        var temp = [String]()
        var j = 0
        while(j < Movies.results[index].characters.count - 1){
            guard let urlObj = URL(string: Movies.results[index].characters[j]) else {return}
            
            
            URLSession.shared.dataTask(with: urlObj) {(data, response, error) in
                do{
                    chars.append(try JSONDecoder().decode(Character.self, from: data!))
                    
                    
                }catch{
                    print("Couldn't fetch data")
                }
                }.resume()
            j += 1
        }
 
        */
        
        switch(Movies.results[index].title){
        case "A New Hope":
            movImg.image = UIImage(named: "a-new-hope")
            break
        case "The Phantom Menace":
            movImg.image = UIImage(named: "the-phantom-menace")
            break
        case "Attack of the Clones":
            movImg.image = UIImage(named: "attack-of-the-clones")
            break
        case "Revenge of the Sith":
            movImg.image = UIImage(named: "revenge-of-the-sith")
            break
        case "Return of the Jedi":
            movImg.image = UIImage(named: "return-of-the-jedi")
            break
        case "The Empire Strikes Back":
            movImg.image = UIImage(named: "empire-strikes-back")
            break
        case "The Force Awakens":
            movImg.image = UIImage(named: "the-force-awakens")
            break
        default:
            print("Couldn't run switch")
        }
        // Do any additional setup after loading the view.
        
        
    }
    
    
    
    @IBAction func characterButton(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CharacterVC") as! CharsTableViewController

        
        nextVC.Movies = self.Movies
        nextVC.index = index
        self.present(nextVC, animated: true, completion: nil)
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
