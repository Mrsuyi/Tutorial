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

@interface TableViewController ()  <UISearchResultsUpdating,
UISearchBarDelegate, UISearchControllerDelegate>

@end

@implementation TableViewController {
  ResultController* _resultController;
  UISearchController* _searchController;
  NSMutableArray<UITableViewCell*>* _cells;
  BOOL _hideTop;
}

- (instancetype)init {
  if (!(self = [super init]))
    return nil;
  
  _hideTop = NO;
  self.title = @"TableViewController";
  
  _cells = [NSMutableArray new];
  for (int i = 0; i < 9; ++i) {
    UITableViewCell* cell = [UITableViewCell new];
    cell.textLabel.text = [NSString stringWithFormat:@"cell %d", i];
    [_cells addObject:cell];
  }

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

  return self;
}

# pragma UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.estimatedRowHeight = 100;
//  self.tableView.estimatedSectionHeaderHeight = 100;
  self.tableView.estimatedSectionFooterHeight = 100;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  NSLog(@"changed!!!!");
}

# pragma UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  if (_hideTop)
    return 2;
  return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  return _cells[indexPath.section * 3 + indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3;
}

# pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//  [self.navigationController pushViewController:[ResultController new] animated:YES];
  [self.navigationController pushViewController:[TableViewController new] animated:YES];
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
  UITableViewHeaderFooterView* header = [UITableViewHeaderFooterView new];
  header.textLabel.text = @"shit";
  header.detailTextLabel.text = @"sub-shit";
  return header;
//  UILabel* label = [[UILabel alloc] init];
//  label.text = [NSString stringWithFormat:@"Section %ld", section];
//  return label;
}

//- (CGFloat)tableView:(UITableView *)tableView
//heightForHeaderInSection:(NSInteger)section {
//  return 50;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView
//heightForFooterInSection:(NSInteger)section {
//  return 10;
//}

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

- (void)willDismissSearchController:(UISearchController *)searchController {
  NSLog(@"willDismissSearchController");
  _hideTop = NO;
  [self.tableView performBatchUpdates:^{
    [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
  } completion:nil];
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

