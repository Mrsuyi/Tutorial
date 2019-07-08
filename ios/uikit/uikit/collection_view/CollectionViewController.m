//
//  CollectionViewController.m
//  uikit
//
//  Created by Yi Su on 1/10/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "CollectionViewController.h"

#import "CollectionViewCell.h"
#import "CollectionViewFlowLayout.h"

@interface CollectionViewController () <UICollectionViewDelegateFlowLayout>
@end

@implementation CollectionViewController {
}

- (instancetype)init {
  self = [super initWithCollectionViewLayout:[CollectionViewFlowLayout new]];
  if (self) {
    self.view.backgroundColor = UIColor.whiteColor;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.collectionView registerClass:CollectionViewCell.class
            forCellWithReuseIdentifier:@"shit"];
  }
  return self;
}

#pragma UITraitEnvironment

- (void)traitCollectionDidChange:(UITraitCollection*)previousTraitCollection {
  [self.collectionView reloadData];
}

#pragma UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:
    (UICollectionView*)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 12;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView
                 cellForItemAtIndexPath:(NSIndexPath*)indexPath {
  return [collectionView dequeueReusableCellWithReuseIdentifier:@"shit"
                                                   forIndexPath:indexPath];
}

- (NSArray<NSString*>*)indexTitlesForCollectionView:
    (UICollectionView*)collectionView {
  return @[ @"1", @"1", @"1", @"2", @"2", @"2" ];
}

- (NSIndexPath*)collectionView:(UICollectionView*)collectionView
        indexPathForIndexTitle:(NSString*)title
                       atIndex:(NSInteger)index {
  return [NSIndexPath indexPathForItem:index
                             inSection:([title isEqualToString:@"1"] ? 0 : 1)];
}

#pragma UICollectionViewDelegateFlowLayout

//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout *)collectionViewLayout
//  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//  return CGSizeMake(40, 20);
//}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsMake(100, 0, 5, 50);
}

- (CGFloat)collectionView:(UICollectionView*)collectionView
                                 layout:(UICollectionViewLayout*)
                                            collectionViewLayout
    minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return 0;
}

- (CGFloat)collectionView:(UICollectionView*)collectionView
                                      layout:(UICollectionViewLayout*)
                                                 collectionViewLayout
    minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  return 40;
}

- (CGSize)collectionView:(UICollectionView*)collectionView
                             layout:
                                 (UICollectionViewLayout*)collectionViewLayout
    referenceSizeForHeaderInSection:(NSInteger)section {
  return CGSizeMake(10, 10);
}

- (CGSize)collectionView:(UICollectionView*)collectionView
                             layout:
                                 (UICollectionViewLayout*)collectionViewLayout
    referenceSizeForFooterInSection:(NSInteger)section {
  return CGSizeMake(10, 10);
}

@end
