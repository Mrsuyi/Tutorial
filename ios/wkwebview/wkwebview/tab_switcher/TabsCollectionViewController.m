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
  TabCell* _sizeReferenceCell;
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

    _tabModels = [[NSMutableArray alloc] init];
    _sizeReferenceCell = [[TabCell alloc] init];
    _sizeReferenceCell.titleLabel.text = @"size reference";
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
  if (tabModel.incognito) {
    cell.titleLabel.backgroundColor = UIColor.darkGrayColor;
    cell.titleLabel.textColor = UIColor.whiteColor;
  }
  cell.titleLabel.text = tabModel.title;
  cell.screenShotView.image = tabModel.screenShot;
  return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (_tabModels.count == 0)
    return CGSizeZero;
  CGSize screenShotSize = _tabModels[0].screenShot.size;
  CGSize collectionViewSize = self.collectionView.frame.size;
  NSUInteger maxCellsPerRow = 2;
  if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
    maxCellsPerRow = self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 3 : 4;
  }
  NSUInteger cellsPerRow = MIN(_tabModels.count, maxCellsPerRow);
  CGFloat width = collectionViewSize.width * 0.9 / cellsPerRow;
  _sizeReferenceCell.screenShotView.image = _tabModels[0].screenShot;
  CGSize idealSize = [_sizeReferenceCell systemLayoutSizeFittingSize:CGSizeMake(width, 2000) withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:1];
  return idealSize;
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

- (BOOL)hasTabModel:(TabModel *)tabModel {
  for (NSInteger i = 0; i < _tabModels.count; ++i) {
    if (_tabModels[i].ID == tabModel.ID)
      return YES;
  }
  return NO;
}

- (void)updateTabModel:(TabModel *)tabModel {
  for (NSUInteger i = 0; i < _tabModels.count; ++i) {
    // Ignore TabModel.incognito.
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
