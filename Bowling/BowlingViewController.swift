//
//  BowlingViewController.swift
//  Bowling
//
//  Created by Apurva Kochar on 8/5/18.
//  Copyright © 2018 Emirates. All rights reserved.
//

import UIKit



class BowlingViewController: UICollectionViewController {
    private let reuseIdentifier = "ScoreCell"
    lazy var automaticBowlingScorer = AutomaticBowlerScorer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initScorer()
    }
    
    private func initScorer() {
        automaticBowlingScorer.reloadViewClosure = {[weak self] in
            self?.collectionView?.reloadData()
        }
        automaticBowlingScorer.roll(10)
        automaticBowlingScorer.roll(5)
        automaticBowlingScorer.roll(5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return automaticBowlingScorer.frameNumber()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ScoreCell
        let cellVM = automaticBowlingScorer.scoreForTheFrame(at: indexPath)
        cell.score.text = String(cellVM)
        return cell
    }

  
}
