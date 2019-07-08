//
//  TableViewController.m
//  SearchBar
//
//  Created by Yi Su on 02/12/2018.
//  Copyright © 2018 google. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BarButtonItem.h"
#import "ResultController.h"
#import "TableViewCell.h"
#import "TableViewController.h"
#import "TableViewHeaderFooterView.h"

@interface TableViewController () <UISearchResultsUpdating,
                                   UISearchBarDelegate,
                                   UISearchControllerDelegate>

@end

@implementation TableViewController {
  ResultController* _resultController;
  BOOL _hideTop;
}

- (instancetype)init {
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    self.title = @"TableViewController";
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    _hideTop = NO;

    // Search bar.
    UISearchController* _searchController;

    _resultController = [ResultController new];

    _searchController =
        [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.delegate = self;
    _searchController.searchBar.delegate = self;
    _searchController.obscuresBackgroundDuringPresentation = YES;

    self.navigationItem.searchController = _searchController;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
    //  self.navigationItem.rightBarButtonItem = [RightBarButton new];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                             target:self
                             action:@selector(onEdit)];

    // TableView
    [self.tableView registerClass:TableViewCell.class
           forCellReuseIdentifier:kTableViewCellReuseIdentifier];
    [self.tableView registerClass:TableViewHeaderFooterView.class
        forHeaderFooterViewReuseIdentifier:
            kTableViewHeaderFooterViewReuseIdentifier];
    [self.tableView registerClass:UITableViewHeaderFooterView.class
        forHeaderFooterViewReuseIdentifier:@"UITableViewHeaderFooterView"];
  }
  return self;
}

#pragma UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.estimatedRowHeight = 60;
  self.tableView.estimatedSectionHeaderHeight = 60;
  self.tableView.estimatedSectionFooterHeight = 50;
}

- (void)didMoveToParentViewController:(UIViewController*)parent {
  NSLog(@"didMoveToParentViewController");
  if (!parent && self.navigationItem.searchController.active == YES) {
    self.navigationItem.searchController.active = NO;
    NSLog(@"Deactivate UISearchController");
  }
  [super didMoveToParentViewController:parent];
}

#pragma UITraitEnvironment

- (void)traitCollectionDidChange:(UITraitCollection*)previousTraitCollection {
  NSLog(@"changed!!!!");
}

#pragma UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
  if (_hideTop)
    return 5;
  return 6;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
  return [self.tableView
      dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier
                           forIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView*)tableView
    numberOfRowsInSection:(NSInteger)section {
  return 3;
}

- (void)tableView:(UITableView*)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
     forRowAtIndexPath:(NSIndexPath*)indexPath {
}

- (BOOL)tableView:(UITableView*)tableView
    canEditRowAtIndexPath:(NSIndexPath*)indexPath {
  return indexPath.section & 1;
}

#pragma UITableViewDelegate

- (void)tableView:(UITableView*)tableView
    didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  [self.navigationController pushViewController:[TableViewController new]
                                       animated:YES];
}

- (UIView*)tableView:(UITableView*)tableView
    viewForHeaderInSection:(NSInteger)section {
  if ((section ^ _hideTop) & 1) {
    UITableViewHeaderFooterView* view =
        [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:
                            @"UITableViewHeaderFooterView"];
    view.textLabel.text = @"the header of 2,4,6... sections";
    view.textLabel.textColor = UIColor.redColor;
    return view;
  }
  TableViewHeaderFooterView* view =
      [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:
                          kTableViewHeaderFooterViewReuseIdentifier];
  if (!view) {
    view = [[TableViewHeaderFooterView alloc]
        initWithReuseIdentifier:kTableViewHeaderFooterViewReuseIdentifier];
  }
  return view;
}

- (CGFloat)tableView:(UITableView*)tableView
    heightForHeaderInSection:(NSInteger)section {
  UITableViewHeaderFooterView* view =
      [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:
                          kTableViewHeaderFooterViewReuseIdentifier];
  CGSize size = [view systemLayoutSizeFittingSize:tableView.bounds.size
                    withHorizontalFittingPriority:UILayoutPriorityRequired
                          verticalFittingPriority:1];
  return size.height;
}

- (CGFloat)tableView:(UITableView*)tableView
    heightForFooterInSection:(NSInteger)section {
  return 0;
}

#pragma UISearchBarDelegate

- (void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)searchText {
  if ([searchText isEqualToString:@"Shit"]) {
    //    self.navigationItem.searchController.active = NO;
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:^{
                                                        NSLog(@"dismissed!!");
                                                      }];
  }
  NSLog(@"searchBar:textDidChange:");
}

- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar {
  NSLog(@"searchBarSearchButtonClicked:");
  [searchBar resignFirstResponder];
}

#pragma UISearchControllerDelegate

- (void)willPresentSearchController:(UISearchController*)searchController {
  NSLog(@"willPresentSearchController");
  _hideTop = YES;
  [self.tableView
      performBatchUpdates:^{
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:0]
                      withRowAnimation:UITableViewRowAnimationTop];
      }
               completion:nil];
}

- (void)didPresentSearchController:(UISearchController*)searchController {
  NSLog(@"didPresentSearchController");
}

- (void)didDismissSearchController:(UISearchController*)searchController {
  NSLog(@"didDismissSearchController");
}

- (void)willDismissSearchController:(UISearchController*)searchController {
  NSLog(@"willDismissSearchController");
  _hideTop = NO;
  [self.tableView
      performBatchUpdates:^{
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0]
                      withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView
            insertRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:0
                                                         inSection:0] ]
                  withRowAnimation:UITableViewRowAnimationMiddle];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4]
                      withRowAnimation:UITableViewRowAnimationAutomatic];
      }
               completion:^(BOOL finished){
               }];
}

#pragma UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:
    (UISearchController*)searchController {
  NSLog(@"updateSearchResultsForSearchController with text:%@",
        searchController.searchBar.text);
  if ([searchController.searchBar.text isEqualToString:@""]) {
    searchController.obscuresBackgroundDuringPresentation = YES;
  } else {
    searchController.obscuresBackgroundDuringPresentation = NO;
  }
}

#pragma Private

- (void)onEdit {
  [self setEditing:!self.editing animated:YES];
  if (self.editing) {
    self.navigationItem.rightBarButtonItem.title = @"Done";
    self.navigationItem.searchController.searchBar.userInteractionEnabled = NO;
    self.navigationItem.searchController.searchBar.alpha = 0.5;
  } else {
    self.navigationItem.rightBarButtonItem.title = @"Edit";
    self.navigationItem.searchController.searchBar.userInteractionEnabled = YES;
    self.navigationItem.searchController.searchBar.alpha = 1.0;
  }
}

@end
