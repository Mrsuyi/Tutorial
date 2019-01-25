//
//  TableViewController.m
//  SearchBar
//
//  Created by Yi Su on 02/12/2018.
//  Copyright © 2018 google. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TableViewController.h"
#import "ResultController.h"
#import "BarButtonItem.h"
#import "TableViewCell.h"
#import "TableViewHeaderFooterView.h"

@interface TableViewController ()  <UISearchResultsUpdating,
UISearchBarDelegate, UISearchControllerDelegate>

@end

@implementation TableViewController {
  ResultController* _resultController;
  UISearchController* _searchController;
  BOOL _hideTop;
}

- (instancetype)init {
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    self.title = @"TableViewController";
    _hideTop = NO;

    // Search bar.
    _resultController = [ResultController new];

    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.delegate = self;
    _searchController.searchBar.delegate = self;
    _searchController.obscuresBackgroundDuringPresentation = YES;
    
    self.navigationItem.searchController = _searchController;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
    //  self.navigationItem.rightBarButtonItem = [RightBarButton new];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(onEdit)];

    self.definesPresentationContext = YES;

    // TableView
    [self.tableView registerClass:TableViewCell.class forCellReuseIdentifier:kTableViewCellReuseIdentifier];
    [self.tableView registerClass:TableViewHeaderFooterView.class forHeaderFooterViewReuseIdentifier:kTableViewHeaderFooterViewReuseIdentifier];
    [self.tableView registerClass:UITableViewHeaderFooterView.class forHeaderFooterViewReuseIdentifier:@"UITableViewHeaderFooterView"];
  }
  return self;
}

# pragma UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.estimatedRowHeight = 60;
  self.tableView.estimatedSectionHeaderHeight = 60;
  self.tableView.estimatedSectionFooterHeight = 50;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  NSLog(@"changed!!!!");
}

# pragma UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  if (_hideTop)
    return 5;
  return 6;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [self.tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier forIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3;
}

# pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  [self.navigationController pushViewController:[TableViewController new] animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
  if (section & 1) {
    UITableViewHeaderFooterView* view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    view.textLabel.text = @"shit";
    view.textLabel.textColor = UIColor.redColor;
    return view;
  }
  TableViewHeaderFooterView* view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:kTableViewHeaderFooterViewReuseIdentifier];
  if (!view) {
    view = [[TableViewHeaderFooterView alloc] initWithReuseIdentifier:kTableViewHeaderFooterViewReuseIdentifier];
  }
  return view;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
  if (_hideTop) {
    if (section & 1)
      return 60;
    else
      return 30;
  } else {
    if (section & 1)
      return 30;
    else
      return 60;
  }
  return UITableViewAutomaticDimension;
//  return 70;
  UITableViewHeaderFooterView* view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:kTableViewHeaderFooterViewReuseIdentifier];
  CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
  return size.height;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
//  return UITableViewAutomaticDimension;
  return 0;
}

# pragma UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText {
  NSLog(@"searchBar:textDidChange:");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  NSLog(@"searchBarSearchButtonClicked:");
  [searchBar resignFirstResponder];
}

#pragma UISearchControllerDelegate

- (void)willPresentSearchController:(UISearchController *)searchController {
  NSLog(@"willPresentSearchController");
  _hideTop = YES;
  [self.tableView performBatchUpdates:^{
    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
  } completion:nil];
}

- (void)didPresentSearchController:(UISearchController *)searchController {
  NSLog(@"didPresentSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController {
  NSLog(@"didDismissSearchController");
}

- (void)willDismissSearchController:(UISearchController *)searchController {
  NSLog(@"willDismissSearchController");
  _hideTop = NO;
  [self.tableView performBatchUpdates:^{
    [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0],
                                             //                                             [NSIndexPath indexPathForRow:1 inSection:0],
                                             //                                             [NSIndexPath indexPathForRow:2 inSection:0],
                                             ] withRowAnimation:UITableViewRowAnimationMiddle];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationAutomatic];
  } completion:^(BOOL finished) {
    //    [self.tableView reloadData];
  }];
}

# pragma UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
  NSLog(@"updateSearchResultsForSearchController with text:%@", searchController.searchBar.text);
  if ([searchController.searchBar.text isEqualToString:@""]) {
    searchController.obscuresBackgroundDuringPresentation = YES;
  }
  else {
    searchController.obscuresBackgroundDuringPresentation = NO;
  }
}

#pragma Private

- (void)onEdit {
  if (self.editing) {
    self.navigationItem.searchController.searchBar.userInteractionEnabled = YES;
    self.navigationItem.searchController.searchBar.alpha = 1.0;
  }
  else {
    self.navigationItem.searchController.searchBar.userInteractionEnabled = NO;
    self.navigationItem.searchController.searchBar.alpha = 0.5;
  }
  [self setEditing:!self.editing animated:YES];
}

@end

