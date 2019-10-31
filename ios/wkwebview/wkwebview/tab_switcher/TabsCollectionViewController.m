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

@interface TabsCollectionViewController () <UICollectionViewDelegateFlowLayout,
                                            TabCellDelegate,
                                            WebViewListObserver>

@property(nonatomic, strong) NSMutableArray<TabModel*>* tabModels;

@end

@implementation TabsCollectionViewController {
  UICollectionViewFlowLayout* _flowLayout;
  TabCell* _sizeReferenceCell;
}

- (instancetype)init {
  UICollectionViewFlowLayout* layout =
      [[UICollectionViewFlowLayout alloc] init];
  layout.scrollDirection = UICollectionViewScrollDirectionVertical;
  layout.minimumLineSpacing = 8;
  layout.minimumInteritemSpacing = 8;
  layout.sectionInset = UIEdgeInsetsMake(16, 0, 16, 0);
  self = [super initWithCollectionViewLayout:layout];
  if (self) {
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.collectionView registerClass:TabCell.class
            forCellWithReuseIdentifier:kTabCellReuseIdentifier];

    _tabModels = [[NSMutableArray alloc] init];
    _sizeReferenceCell = [[TabCell alloc] init];
    _sizeReferenceCell.titleLabel.text = @"size reference";
    _flowLayout = layout;
  }
  return self;
}

#pragma mark - UITraitEnvironment

- (void)traitCollectionDidChange:(UITraitCollection*)previousTraitCollection {
  [self.collectionView reloadData];
}

#pragma mark -  UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:
    (UICollectionView*)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.tabModels.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView
                 cellForItemAtIndexPath:(NSIndexPath*)indexPath {
  TabModel* tabModel = self.tabModels[indexPath.item];
  TabCell* cell = (TabCell*)[collectionView
      dequeueReusableCellWithReuseIdentifier:kTabCellReuseIdentifier
                                forIndexPath:indexPath];
  cell.incognito = tabModel.webView.incognito;
  cell.titleLabel.text = tabModel.webView.WKWebView.title;
  cell.screenShotView.image = tabModel.screenShot;
  cell.highlighted = self.webViewList.activeIndex == indexPath.item;
  cell.delegate = self;
  return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView*)collectionView
                    layout:(UICollectionViewLayout*)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath*)indexPath {
  if (self.tabModels.count == 0) {
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.sectionInset = UIEdgeInsetsZero;
    return CGSizeZero;
  }

  // Calculate number of cells per row.
  NSUInteger maxCellsPerRow = 2;
  if (self.traitCollection.horizontalSizeClass ==
      UIUserInterfaceSizeClassRegular) {
    maxCellsPerRow = self.traitCollection.verticalSizeClass ==
                             UIUserInterfaceSizeClassCompact
                         ? 3
                         : 4;
  }
  NSUInteger cellsPerRow = MIN(self.tabModels.count, maxCellsPerRow);
  CGSize collectionViewSize = self.collectionView.frame.size;

  // Calculate space between rows, columns, and padding.
  CGFloat totalSpace = floor(collectionViewSize.width * 0.2);
  CGFloat space = floor(totalSpace / (cellsPerRow + 1));
  _flowLayout.minimumInteritemSpacing = space;
  _flowLayout.minimumLineSpacing = space;
  _flowLayout.sectionInset = UIEdgeInsetsMake(space, space, space, space);

  // Calculate cell size.
  CGFloat width = floor(collectionViewSize.width * 0.8 / cellsPerRow);
  CGSize cellSize = [_sizeReferenceCell.contentView
      systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
  cellSize.width = width;
  if (self.tabModels[0].screenShot) {
    CGSize screenShotSize = self.tabModels[0].screenShot.size;
    cellSize.height += screenShotSize.height * (width / screenShotSize.width);
  }
  return cellSize;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView*)collectionView
    didSelectItemAtIndexPath:(NSIndexPath*)indexPath {
  NSAssert(indexPath.item >= 0 && indexPath.item < self.webViewList.count,
           @"selected tab must have a valid index");
  self.webViewList.activeIndex = indexPath.item;
  [self.delegate tabsCollection:self
               didSelectWebView:self.webViewList[indexPath.item]];
  [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - TabCellDelegate

- (void)tabCellDidTapCloseButton:(TabCell*)tabCell {
  NSIndexPath* indexPath = [self.collectionView indexPathForCell:tabCell];
  [self.webViewList removeWebViewAtIndex:indexPath.item];
}

#pragma mark - WebViewListObserver

- (void)webViewList:(WebViewList*)webViewList
    willActivateWebView:(WebView*)webView
                atIndex:(NSUInteger)index {
  NSAssert(webViewList == self.webViewList, @"WebViewList mismatch");
  // Unhighlight current active tab.
  [self.collectionView reloadItemsAtIndexPaths:@[
    [NSIndexPath indexPathForItem:self.webViewList.activeIndex inSection:0]
  ]];
}

- (void)webViewList:(WebViewList*)webViewList
    didActivateWebView:(WebView*)webView1
               atIndex:(NSUInteger)index1
       deactiveWebView:(WebView*)webView2
               atIndex:(NSUInteger)index2 {
  NSAssert(webViewList == self.webViewList, @"WebViewList mismatch");
  // Highlight new active tab.
  [self.collectionView reloadItemsAtIndexPaths:@[
    [NSIndexPath indexPathForItem:index1 inSection:0],
    [NSIndexPath indexPathForItem:index2 inSection:0]
  ]];
}

- (void)webViewList:(WebViewList*)webViewList
    didInsertWebView:(WebView*)webView
             atIndex:(NSUInteger)index {
  NSAssert(webViewList == self.webViewList, @"WebViewList mismatch");
  [self.tabModels insertObject:[TabModel modelWithWebView:webView]
                       atIndex:self.tabModels.count];
  [self.collectionView reloadData];
}

- (void)webViewList:(WebViewList*)webViewList
    willRemoveWebView:(WebView*)webView
              atIndex:(NSUInteger)index {
  NSAssert(webViewList == self.webViewList, @"WebViewList mismatch");
  [self.tabModels removeObjectAtIndex:index];
  [self.collectionView
      deleteItemsAtIndexPaths:@[ [NSIndexPath indexPathForItem:index
                                                     inSection:0] ]];
}

#pragma mark - Public methods

- (void)setWebViewList:(WebViewList*)webViewList {
  if (_webViewList) {
    [_webViewList removeObserver:self];
  }
  _webViewList = webViewList;
  [webViewList addObserver:self];
}

- (void)updateWebViewScreenShot:(WebView*)webView {
  WKSnapshotConfiguration* conf = [[WKSnapshotConfiguration alloc] init];
  __weak TabsCollectionViewController* weakSelf = self;
  [webView.WKWebView
      takeSnapshotWithConfiguration:conf
                  completionHandler:^(UIImage* _Nullable snapshotImage,
                                      NSError* _Nullable error) {
                    if (error) {
                      NSLog(@"WKWebView takeSnapshot failed: %@", error);
                      return;
                    }
                    if (!weakSelf) {
                      return;
                    }
                    TabsCollectionViewController* strongSelf = weakSelf;
                    NSUInteger index =
                        [strongSelf.webViewList indexOfWebView:webView];
                    if (index == NSNotFound) {
                      NSLog(@"WebView not found after screenshot is taken");
                      return;
                    }
                    strongSelf.tabModels[index].screenShot = snapshotImage;
                    [strongSelf.collectionView reloadItemsAtIndexPaths:@[
                      [NSIndexPath indexPathForItem:index inSection:0]
                    ]];
                  }];
}

@end
