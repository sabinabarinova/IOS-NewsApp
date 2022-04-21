
import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class DetailedView: UIViewController {
    
    var indexRow: Int?
    var titleName: String?
    var descriptionContent: String?
    var author: String?
    var date: String?
    var url: String?
    var urlImage: String?

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var urlLabel: UILabel!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleName
//        descriptionLabel.adjustsFontSizeToFitWidth = true;
        descriptionLabel.text = descriptionContent
        dateLabel.text = date
        authorLabel.text = author
        urlLabel.text = url
        AF.request(urlImage!).responseImage { response in
            debugPrint(response)

            print(response.request!)
            print(response.response!)
            debugPrint(response.result)

            if case .success(let image) = response.result {
                self.image.image = image
            }
        }

    }
}
