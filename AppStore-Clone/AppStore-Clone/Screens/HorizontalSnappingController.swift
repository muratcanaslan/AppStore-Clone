//
//  HorizontalSnappingController.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 17.02.2023.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    init() {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SnappingLayout: UICollectionViewFlowLayout {
    //MARK: - Snap Behaviour
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
            
            guard let collectionView = collectionView else {
                return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            }
            
            let nextX: CGFloat
            
            if proposedContentOffset.x <= 0 || collectionView.contentOffset == proposedContentOffset {
                nextX = proposedContentOffset.x
            } else {
                nextX = collectionView.contentOffset.x + (velocity.x > 0 ? collectionView.bounds.size.width : -collectionView.bounds.size.width)
            }
            
            let targetRect = CGRect(x: nextX, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
            
            var offsetAdjustment = CGFloat.greatestFiniteMagnitude
            
            let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left
            
            let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)
            
            layoutAttributesArray?.forEach({ (layoutAttributes) in
                let itemOffset = layoutAttributes.frame.origin.x
                if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
                    offsetAdjustment = itemOffset - horizontalOffset
                }
            })
            
            return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
        }
}
