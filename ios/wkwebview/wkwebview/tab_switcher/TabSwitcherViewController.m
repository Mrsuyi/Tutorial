//
//  TabSwitcherViewController.m
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "TabSwitcherViewController.h"
#import "TabsCollectionViewController.h"

@interface TabSwitcherViewController () <TabsCollectionDelegate>

@property(nonatomic, strong)
    TabsCollectionViewController* regularTabsCollectionVC;
@property(nonatomic, strong)
    TabsCollectionViewController* incognitoTabsCollectionVC;
@property(nonatomic, strong)
    TabsCollectionViewController* shownTabsCollectionVC;

- (UIBarButtonItem*)newTabBtn __attribute__((objc_method_family(none)));
@property(nonatomic, strong) UIBarButtonItem* incognitoBtn;
@property(nonatomic, strong) UIBarButtonItem* newTabBtn;
@property(nonatomic, strong) UIBarButtonItem* doneBtn;

@end

@implementation TabSwitcherViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    _regularTabsCollectionVC = [TabsCollectionViewController new];
    _regularTabsCollectionVC.delegate = self;
    _regularTabsCollectionVC.webViewList = GetRegularWebViewList();
    _incognitoTabsCollectionVC = [TabsCollectionViewController new];
    _incognitoTabsCollectionVC.delegate = self;
    _incognitoTabsCollectionVC.webViewList = GetIncognitoWebViewList();

    _shownTabsCollectionVC = nil;
  }
  return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Setup bottom toolbar.
  self.incognitoBtn =
      [[UIBarButtonItem alloc] initWithTitle:@"Regular"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(onIncognitoBtnTapped:)];
  self.newTabBtn = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                           target:self
                           action:@selector(onNewTabBtnTapped:)];
  self.doneBtn = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                           target:self
                           action:@selector(onDoneBtnTapped:)];
  UIBarButtonItem* space = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                           target:nil
                           action:nil];

  UIToolbar* toolbar = [UIToolbar new];
  toolbar.translatesAutoresizingMaskIntoConstraints = NO;
  [toolbar setItems:@[
    self.incognitoBtn, space, self.newTabBtn, space, self.doneBtn
  ]];
  toolbar.translucent = YES;
  toolbar.barStyle = UIBarStyleBlack;
  [toolbar setShadowImage:[UIImage new] forToolbarPosition:UIBarPositionAny];

  // Setup TabsCollection.
  [self addChildViewController:_regularTabsCollectionVC];
  self.regularTabsCollectionVC.view.translatesAutoresizingMaskIntoConstraints =
      NO;
  [self addChildViewController:_incognitoTabsCollectionVC];
  self.incognitoTabsCollectionVC.view
      .translatesAutoresizingMaskIntoConstraints = NO;

  // Setup TabsCollectionContainer.
  UIView* tabsCollectionContainer = [UIView new];
  tabsCollectionContainer.translatesAutoresizingMaskIntoConstraints = NO;
  [tabsCollectionContainer addSubview:self.incognitoTabsCollectionVC.view];
  [tabsCollectionContainer addSubview:self.regularTabsCollectionVC.view];
  [NSLayoutConstraint activateConstraints:@[
    [self.incognitoTabsCollectionVC.view.leadingAnchor
        constraintEqualToAnchor:tabsCollectionContainer.leadingAnchor],
    [self.incognitoTabsCollectionVC.view.trailingAnchor
        constraintEqualToAnchor:tabsCollectionContainer.trailingAnchor],
    [self.incognitoTabsCollectionVC.view.topAnchor
        constraintEqualToAnchor:tabsCollectionContainer.topAnchor],
    [self.incognitoTabsCollectionVC.view.bottomAnchor
        constraintEqualToAnchor:tabsCollectionContainer.bottomAnchor],
    //
    [self.regularTabsCollectionVC.view.leadingAnchor
        constraintEqualToAnchor:tabsCollectionContainer.leadingAnchor],
    [self.regularTabsCollectionVC.view.trailingAnchor
        constraintEqualToAnchor:tabsCollectionContainer.trailingAnchor],
    [self.regularTabsCollectionVC.view.topAnchor
        constraintEqualToAnchor:tabsCollectionContainer.topAnchor],
    [self.regularTabsCollectionVC.view.bottomAnchor
        constraintEqualToAnchor:tabsCollectionContainer.bottomAnchor],
  ]];

  // Setup self.view.
  [self.view addSubview:toolbar];
  [self.view addSubview:tabsCollectionContainer];
  [NSLayoutConstraint activateConstraints:@[
    [tabsCollectionContainer.leadingAnchor
        constraintEqualToAnchor:self.view.leadingAnchor],
    [tabsCollectionContainer.trailingAnchor
        constraintEqualToAnchor:self.view.trailingAnchor],
    [tabsCollectionContainer.topAnchor
        constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
    [tabsCollectionContainer.bottomAnchor
        constraintEqualToAnchor:toolbar.topAnchor],
    //
    [toolbar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
    [toolbar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    [toolbar.bottomAnchor
        constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
  ]];
  self.incognitoTabsCollectionVC.view.hidden = YES;
  self.shownTabsCollectionVC = self.regularTabsCollectionVC;
}

#pragma mark - TabsCollectionDelegate

- (void)tabsCollection:(TabsCollectionViewController*)tabsCollectionVC
      didSelectWebView:(WebView*)webView {
  [self.delegate tabSwitcher:self didSelectWebView:webView];
}

#pragma mark - Button callbacks

- (void)onIncognitoBtnTapped:(id)sender {
  self.newTabBtn.enabled = NO;

  TabsCollectionViewController* hiddenTabsCollectionVC =
      (self.shownTabsCollectionVC == self.regularTabsCollectionVC)
          ? self.incognitoTabsCollectionVC
          : self.regularTabsCollectionVC;
  [UIView transitionFromView:self.shownTabsCollectionVC.view
                      toView:hiddenTabsCollectionVC.view
                    duration:0.3
                     options:UIViewAnimationOptionShowHideTransitionViews |
                             UIViewAnimationOptionTransitionFlipFromLeft |
                             UIViewAnimationCurveEaseInOut
                  completion:^(BOOL finished) {
                    self.shownTabsCollectionVC = hiddenTabsCollectionVC;
                    self.newTabBtn.enabled = YES;
                    self.incognitoBtn.title =
                        [self.incognitoBtn.title isEqualToString:@"Regular"]
                            ? @"Incognito"
                            : @"Regular";
                  }];
}

- (void)onNewTabBtnTapped:(id)sender {
  [self.delegate tabSwitcher:self
      didTapNewTabButtonInIncognitoMode:self.shownTabsCollectionVC ==
                                        self.incognitoTabsCollectionVC];
}

- (void)onDoneBtnTapped:(id)sender {
  [self.delegate tabSwitcherDidTapDoneButton:self];
}

#pragma mark - Public

- (void)updateWebViewScreenShot:(WebView*)webView {
  if (webView.incognito) {
    [self.incognitoTabsCollectionVC updateWebViewScreenShot:webView];
  } else {
    [self.regularTabsCollectionVC updateWebViewScreenShot:webView];
  }
}

@end
