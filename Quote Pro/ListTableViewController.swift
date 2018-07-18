//
//  ListTableViewController.swift
//  Quote Pro
//
//  Created by Will Chew on 2018-07-18.
//  Copyright © 2018 Will Chew. All rights reserved.
//

import UIKit


class ListTableViewController: UITableViewController {

    var quoteView: QuoteView!
    var savedQuotes = [SavedQuote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let quoteView = Bundle.main.loadNibNamed("QuoteView", owner: QuoteView.self)?.first as? QuoteView else {
            return
        }
        
        self.quoteView = quoteView
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedQuotes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        cell.quoteLabel.text = savedQuotes[indexPath.row].quote.quote
        cell.authorLabel.font = UIFont.boldSystemFont(ofSize: 17)
        cell.authorLabel.text = savedQuotes[indexPath.row].quote.author
        
        cell.randomImageView.image = UIImage(data: savedQuotes[indexPath.row].picture)
        
        // Configure the cell...

        return cell
    }
 
    
    @IBAction func unwindToMainScreen(sender:UIStoryboardSegue) {
        if sender.source is QuoteBuilderViewController {
            if let senderVC = sender.source as? QuoteBuilderViewController{
                guard let urlString = senderVC.image?.link else {
                    return
                }
                guard let url = URL(string: urlString) else {
                    return
                }
                let data = try? Data(contentsOf: url)

                
                
                let newQuote = SavedQuote(quote: senderVC.quote!, picture: data!)
                savedQuotes.append(newQuote)
                tableView.reloadData()
            }
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////         Get the new view controller using segue.destinationViewController.
////         Pass the selected object to the new view controller.
//
//
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
//    }
}
