//
//  MovieCollectionViewController.swift
//  MoviesDemo
//
//  Created by Shrimant Nikate on 16/11/17.
//  Copyright © 2017 Shrimant Nikate. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "MovieCollectionViewCell"



class MovieCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {

    private var viewModel: MovieCollectionViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieCollectionViewModel(reloadCollection: reloadCollection, delegate: self)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    private func reloadCollection()
    {
        collectionView?.reloadData()
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel.numberOfSectionInCollection()
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return viewModel.numberOfCellInSection(section: section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        return viewModel.setupMovieCollectionViewCell(cell: cell as! MovieCollectionViewCell, forIndexPath: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let size = ((collectionView.frame.width-15) / 2)
        return CGSize(width: size, height: size)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil && segue.identifier == "FilterSegue" {
            guard let navi = segue.destination as? UINavigationController,
            let vm = navi.viewControllers[0] as? FilterTableViewController
            else {
                return
            }
            vm.selectedFilter = viewModel.selectedGenre
            vm.filterDelegate = viewModel
        }
    }
}
