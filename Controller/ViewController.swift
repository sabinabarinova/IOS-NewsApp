

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cells"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel?.numberOfLines = 3
        cell?.textLabel?.font = UIFont(name: "AppleGothic", size: 20)
        cell?.textLabel?.text = NewsTitle[indexPath.row]
        cell?.detailTextLabel?.font = UIFont(name: "AppleGothic", size: 10)
        if (NewsAuthor[indexPath.row] == nil) {
            cell?.detailTextLabel?.text = NewsDate[indexPath.row]!
        }
        
        else {
            cell?.detailTextLabel?.text = NewsDate[indexPath.row]! + "\t" + NewsAuthor[indexPath.row]!
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowSelected = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showView", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showView" {
            let destinationVC = segue.destination as! DetailedView
            destinationVC.indexRow = rowSelected
            destinationVC.titleName = NewsTitle[rowSelected!]
            destinationVC.descriptionContent = NewsDescription[rowSelected!]
            destinationVC.author = NewsAuthor[rowSelected!]
            destinationVC.date = NewsDate[rowSelected!]
            destinationVC.url = NewsUrl[rowSelected!]
            destinationVC.urlImage = NewsUrlToImage[rowSelected!]

        }

    }
    
    let url = "https://newsapi.org/v2/everything?q=tesla&from=2022-03-09&sortBy=publishedAt&apiKey=ffa7f03cf4704f8b80a46f224bbc756a"

    
    @IBOutlet weak var NewsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var NewsTitle = [String?]()
    var NewsAuthor = [String?]()
    var NewsDescription = [String?]()
    var NewsDate = [String?]()
    var NewsUrl = [String?]()
    var NewsUrlToImage = [String?]()
    

    var rowSelected : Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        getNewsBriefly()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getNewsBriefly() {
        
        AF.request(url, method: .get).response { response in
            
            switch response.result {
                
            case .success:
                
                let json = try? JSON(data: response.data!)
                
                let resultArray = json!["articles"]
                
                self.NewsTitle.removeAll()
                self.NewsAuthor.removeAll()
                self.NewsDescription.removeAll()
                self.NewsDate.removeAll()
                self.NewsUrl.removeAll()
                self.NewsUrlToImage.removeAll()

                
                for i in resultArray.arrayValue {
                    let title = i["title"].stringValue
                    self.NewsTitle.append(title)

                    let author = i["author"].stringValue
                    self.NewsAuthor.append(author)

                    
                    let description = i["description"].stringValue
                    self.NewsDescription.append(description)
                    
                    let date = i["publishedAt"].stringValue
                    self.NewsDate.append(date)
                    
                    let newsURL = i["url"].stringValue
                    self.NewsUrl.append(newsURL)
                    
                    let newsURLtoImage = i["urlToImage"].stringValue
                    self.NewsUrlToImage.append(newsURLtoImage)
                }
                
                self.tableView.reloadData()
                
                break
            case .failure:
                print(response.error!)
                break
            }
        }
            
    }

    func setUpUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }
    

}
