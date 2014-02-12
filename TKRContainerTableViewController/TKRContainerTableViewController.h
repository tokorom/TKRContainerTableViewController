//
//  TKRContainerTableViewController.h
//
//  Created by ToKoRo on 2014-01-23.
//

#import "TKRTableViewContained.h"

#ifndef TKR_CONTAINER_TABLE_VIEW_CLASS
#define TKR_CONTAINER_TABLE_VIEW_CLASS UITableView
#endif

#ifdef TKR_CONTAINER_TABLE_VIEW_CLASS_IMPORT
#import TKR_CONTAINER_TABLE_VIEW_CLASS_IMPORT
#endif

#ifdef TKR_CONTAINER_TABLE_VIEW_CONTROLLER_IMPORT
#import TKR_CONTAINER_TABLE_VIEW_CONTROLLER_IMPORT
#endif

#ifdef TKR_CONTAINER_TABLE_VIEW_CONTROLLER_SUPER_CLASS
@interface TKRContainerTableViewController : TKR_CONTAINER_TABLE_VIEW_CONTROLLER_SUPER_CLASS
#else
@interface TKRContainerTableViewController : UIViewController
#endif
<UITableViewDelegate, UITableViewDataSource>

- (UITableView *)tableView;
- (NSArray<TKRTableViewContained> *)controllers;

- (void)addController:(id<TKRTableViewContained>)controller;
- (void)removeAllControllers;
- (id<TKRTableViewContained>)controllerAtIndex:(NSUInteger)index;

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section NS_REQUIRES_SUPER;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section NS_REQUIRES_SUPER;

@end
