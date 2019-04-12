//
//  TabsCollectionViewController.m
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "TabsCollectionViewController.h"
#import "TabCell.h"

NSString* const kTabCellReuseIdentifier = @"shit";

@interface TabsCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@end

@implementation TabsCollectionViewController {
  NSMutableArray<TabModel*>* _tabModels;
}

- (instancetype)init {
  UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
  layout.scrollDirection = UICollectionViewScrollDirectionVertical;
  layout.minimumLineSpacing = 8;
  layout.minimumInteritemSpacing = 8;
  layout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16);
  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.collectionView registerClass:TabCell.class forCellWithReuseIdentifier:kTabCellReuseIdentifier];

    _tabModels = [NSMutableArray new];
  }
  return self;
}

#pragma mark - UITraitEnvironment

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [self.collectionView reloadData];
}

#pragma mark -  UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return _tabModels.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  TabModel* tabModel = _tabModels[indexPath.item];
  TabCell* cell = (TabCell*)[collectionView dequeueReusableCellWithReuseIdentifier:kTabCellReuseIdentifier forIndexPath:indexPath];
  cell.titleLabel.text = tabModel.title;
  cell.screenShotView.image = tabModel.screenShot;
  return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(120, 160);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [self.delegate tabsCollection:self didSelectTab:_tabModels[indexPath.item]];
  [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - Public methods

- (void)addTabModel:(TabModel *)tabModel {
  [_tabModels addObject:tabModel];
  [self.collectionView reloadData];
}

- (void)updateTabModel:(TabModel*)tabModel {
  for (NSUInteger i = 0; i < _tabModels.count; ++i) {
    if (_tabModels[i].ID == tabModel.ID) {
      if (tabModel.title)
        _tabModels[i].title = tabModel.title;
      if (tabModel.screenShot)
        _tabModels[i].screenShot = tabModel.screenShot;
      [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:i inSection:0]]];
      return;
    }
  }
  NSAssert(NO, @"TabModel not found in TabsCollectionVC");
}

@end
