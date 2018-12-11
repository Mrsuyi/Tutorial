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
}

- (instancetype)init {
  if (!(self = [super init]))
    return nil;
  
  self.title = @"TableViewController";
  
  _cells = [NSMutableArray new];
  for (int i = 0; i < 6; ++i) {
    UITableViewCell* cell = [UITableViewCell new];
    cell.textLabel.text = [NSString stringWithFormat:@"cell %d", i];
    [_cells addObject:cell];
  }
  
  _resultController = [ResultController new];
  
  _searchController = [[UISearchController alloc] initWithSearchResultsController:_resultController];
  _searchController.searchResultsUpdater = _resultController;
  _searchController.delegate = self;
  _searchController.searchBar.delegate = self;
  _searchController.dimsBackgroundDuringPresentation = YES;

  self.navigationItem.searchController = _searchController;
  self.navigationItem.hidesSearchBarWhenScrolling = NO;
  self.navigationItem.rightBarButtonItem = [RightBarButton new];

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

# pragma UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  return _cells[indexPath.section * 3 + indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3;
}

# pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.navigationController pushViewController:[ResultController new] animated:YES];
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
  UILabel* label = [[UILabel alloc] init];
  label.text = [NSString stringWithFormat:@"Section %ld", section];
  return label;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
  return 50;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
  return 10;
}

# pragma UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
  NSLog(@"updateSearchResultsForSearchController");
}

# pragma UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  NSLog(@"search button clicked");
  [searchBar resignFirstResponder];
}

#pragma UISearchControllerDelegate

- (void)willPresentSearchController:(UISearchController *)searchController {
  NSLog(@"willPresentSearchController");
}

@end

