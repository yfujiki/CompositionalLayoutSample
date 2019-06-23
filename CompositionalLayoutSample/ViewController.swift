//
//  ViewController.swift
//  CompositionalLayoutSample
//
//  Created by Yuichi Fujiki on 23/6/19.
//  Copyright © 2019 Yuichi Fujiki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum Section: Int {
        case brandNames
        case catFoods
        case cats
    }

    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: Data
    private let brandNames = [
        "Purina",
        "Fancy Feast",
        "Royal Feline",
        "Wilderness",
        "KM",
        "Instinct"
    ]

    private let catFoods: [UIImage] = {
        var images = [UIImage]()
        for i in 1...10 {
            let imageName = String(format: "catfood_%03d", i)
            images.append(UIImage(named: imageName)!)
        }
        return images
    }()

    private let cats: [UIImage] = {
        var images = [UIImage]()
        for i in 1...10 {
            let imageName = "\(i).cat"
            images.append(UIImage(named: imageName)!)
        }
        return images
    }()


    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "LabelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "labelCell")
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .scrollableAxes
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .brandNames:
            return brandNames.count
        case .catFoods:
            return catFoods.count
        case .cats:
            return cats.count
        case .none:
            fatalError("Should not be none")
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section(rawValue: indexPath.section) {
        case .brandNames:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCell", for: indexPath) as! LabelCollectionViewCell
            let name = brandNames[indexPath.item]
            cell.setText(name)
            return cell
        case .catFoods:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
            let image = catFoods[indexPath.item]
            cell.setImage(image)
            return cell
        case .cats:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
            let image = cats[indexPath.item]
            cell.setImage(image)
            return cell
        case .none:
            fatalError("Should not be none")
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch Section(rawValue: indexPath.section) {
        case .brandNames:
            return CGSize(width: 120, height: 44)
        case .catFoods:
            return CGSize(width: 120, height: 80)
        case .cats:
            return CGSize(width: 320, height: 240)
        case .none:
            fatalError("Should not be none")
        }
    }
}

