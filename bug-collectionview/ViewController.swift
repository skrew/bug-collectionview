//
//  ViewController.swift
//  bug-collectionview
//
//  Created by Skrew on 20/10/2019.
//  Copyright © 2019 Nothing. All rights reserved.
//

import UIKit


class Cell: UICollectionViewCell {
    var lbl: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    private func setup() {
        self.lbl = UILabel(frame: .zero)
        self.lbl.translatesAutoresizingMaskIntoConstraints = false
        self.lbl.textColor = .white
        self.contentView.addSubview(self.lbl)
        NSLayoutConstraint.activate([
            self.lbl.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            self.lbl.widthAnchor.constraint(equalTo: self.lbl.heightAnchor),
            self.lbl.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.lbl.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        ])
    }
    
}

class ViewController: UICollectionViewController {
    
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    init() {
        super.init(collectionViewLayout: Self.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.isPrefetchingEnabled = false
        
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    private static func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.14),
                                               heightDimension: .fractionalWidth(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let spacing = CGFloat(50) // 50
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 50, trailing: 25)
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        
        if indexPath.section == 8 && indexPath.row == 0 {
            print("\(Date()) - \(indexPath)")
        }
        
        cell.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        cell.lbl.text = String((0..<10).map{ _ in letters.randomElement()! })
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

