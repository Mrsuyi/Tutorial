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
  for (int i = 0; i < 3; ++i) {
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

  self.definesPresentationContext = YES;

  return self;
}

# pragma UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

# pragma UITableViewDataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  return _cells[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3UL;
}

# pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

