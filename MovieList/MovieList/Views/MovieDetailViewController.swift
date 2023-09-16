//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Shehroz Arif on 11/09/2023.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var movie: MovieEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Movie Detail"
        titleLabel.text = movie?.title
        releaseDateLabel.text = movie?.releaseDate
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
