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

    // MARK: Other Private Properties
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in


            switch Section(rawValue: sectionIndex) {
            case .brandNames:
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalHeight(1.0)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 8.0)

                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(136),
                                                       heightDimension: .absolute(44)),
                    subitem: item,
                    count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                return section
            case .catFoods:
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalHeight(1.0)))
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(80)),
                    subitem: item,
                    count: 2)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                return section
            case .cats:
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                       heightDimension: .fractionalHeight(0.9)))
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
                    leading: NSCollectionLayoutSpacing.flexible(0.0),
                    top: NSCollectionLayoutSpacing.flexible(0.0),
                    trailing: NSCollectionLayoutSpacing.flexible(0.0),
                    bottom: NSCollectionLayoutSpacing.flexible(0.0))

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(240)),
                    subitem: item,
                    count: 1)
                let section = NSCollectionLayoutSection(group: group)
                return section
            case .none:
                fatalError("Should not be none ")
            }
        }
        return layout
    }()

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "LabelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "labelCell")
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        collectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.collectionViewLayout = compositionalLayout
        collectionView.dataSource = self
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

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! HeaderCollectionReusableView
            switch Section(rawValue: indexPath.section) {
            case .brandNames:
                headerView.setText("Brand names")
            case .catFoods:
                headerView.setText("Cat foods")
            case .cats:
                headerView.setText("Cats")
            case .none:
                fatalError("Should not be none")
            }
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
}

