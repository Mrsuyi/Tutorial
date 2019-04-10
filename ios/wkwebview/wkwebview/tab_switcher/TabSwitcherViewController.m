//
//  TabSwitcherViewController.m
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "TabSwitcherViewController.h"
#import "TabsCollectionViewController.h"

@interface TabSwitcherViewController ()<TabsCollectionDelegate>

@end

@implementation TabSwitcherViewController {
  TabsCollectionViewController* _tabsCollectionVC;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _tabsCollectionVC = [TabsCollectionViewController new];
    _tabsCollectionVC.delegate = self;
  }
  return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Setup bottom toolbar.
  UIBarButtonItem* incognitoBtn = [[UIBarButtonItem alloc] initWithTitle:@"Incognito" style:UIBarButtonItemStylePlain target:self action:@selector(onIncognitoBtnTapped:)];
  UIBarButtonItem* newTabBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onNewTabBtnTapped:)];
  UIBarButtonItem* doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDoneBtnTapped:)];
  UIBarButtonItem* space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

  UIToolbar* toolbar = [UIToolbar new];
  toolbar.translatesAutoresizingMaskIntoConstraints = NO;
  [toolbar setItems:@[incognitoBtn, space, newTabBtn, space, doneBtn]];
  toolbar.translucent = YES;
  toolbar.barStyle = UIBarStyleBlack;
  [toolbar setShadowImage:[UIImage new] forToolbarPosition:UIBarPositionAny];

  // Setup TabsCollection.
  [self addChildViewController:_tabsCollectionVC];
  _tabsCollectionVC.view.translatesAutoresizingMaskIntoConstraints = NO;

  // Setup self.view.
  [self.view addSubview:toolbar];
  [self.view addSubview:_tabsCollectionVC.view];
  [NSLayoutConstraint activateConstraints:@[
                                            [_tabsCollectionVC.view.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
                                            [_tabsCollectionVC.view.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
                                            [_tabsCollectionVC.view.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                            [_tabsCollectionVC.view.bottomAnchor constraintEqualToAnchor:toolbar.topAnchor],
                                            [toolbar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                            [toolbar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                            [toolbar.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]]];
}

#pragma mark - TabsCollectionDelegate

- (void)didSelectTab:(TabModel *)tabModel {
  [self.delegate didSelectTab:tabModel];
}

#pragma mark - Button callbacks

- (void)onIncognitoBtnTapped:(id)sender {
}

- (void)onNewTabBtnTapped:(id)sender {
  [self.delegate didTapNewTabButton];
}

- (void)onDoneBtnTapped:(id)sender {
  [self.delegate didTapDoneButton];
}

#pragma mark - Public methods

- (void)addTabModel:(TabModel*)tabModel {
  [_tabsCollectionVC addTabModel:tabModel];
}

- (void)updateTabModel:(TabModel*)tabModel {
  [_tabsCollectionVC updateTabModel:tabModel];
}

@end
