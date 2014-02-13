//
//  TKRContainerTableViewController.m
//
//  Created by ToKoRo on 2014-01-23.
//

#import "TKRContainerTableViewController.h"

@interface TKRContainerTableViewController ()
@property (weak) UITableView *tableView;
@property (strong) NSMutableArray<TKRTableViewContained> *controllers;
@property (assign, getter = isDisappearing) BOOL disappearing;
@end 

@implementation TKRContainerTableViewController

//----------------------------------------------------------------------------//
#pragma mark - View lifecycle
//----------------------------------------------------------------------------//

- (instancetype)init
{
    if ((self = [super init])) {
        [self initMyself];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super initWithCoder:decoder])) {
        [self initMyself];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle
{
    if ((self = [super initWithNibName:nibName bundle:nibBundle])) {
        [self initMyself];
    }
    return self;
}

- (void)initMyself
{
    self.controllers = (NSMutableArray<TKRTableViewContained> *)[NSMutableArray array];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITableView *tableView;
    tableView = [[TKR_CONTAINER_TABLE_VIEW_CLASS alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.disappearing = NO;

    for (id contained in self.controllers) {
        if ([contained respondsToSelector:@selector(willAppearWithTableView:)]) {
            [contained willAppearWithTableView:self.tableView];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.disappearing = YES;
}

//----------------------------------------------------------------------------//
#pragma mark - Public Interface
//----------------------------------------------------------------------------//

- (void)addController:(id<TKRTableViewContained>)controller
{
    if ([controller respondsToSelector:@selector(setParentViewController:)]) {
        [controller setParentViewController:self];
    }
    [(NSMutableArray *)self.controllers addObject:controller];
}

- (void)removeAllControllers
{
    [(NSMutableArray *)self.controllers removeAllObjects];
}

- (id<TKRTableViewContained>)controllerAtIndex:(NSUInteger)index
{
    return self.controllers[index];
}

//----------------------------------------------------------------------------//
#pragma mark - UITableViewDataSource
//----------------------------------------------------------------------------//

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.controllers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<TKRTableViewContained> contained = [self controllerAtIndex:section];
    NSUInteger rows = 0;
    NSUInteger numberOfSections = 1;
    if ([contained.tableViewDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        numberOfSections = [contained.tableViewDataSource numberOfSectionsInTableView:tableView];
    }
    for (int i = 0; i < numberOfSections; ++i) {
        rows += [contained.tableViewDataSource tableView:tableView numberOfRowsInSection:i];
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<TKRTableViewContained> contained = [self controllerAtIndex:indexPath.section];
    indexPath = [self tableView:tableView indexPathForContainedControlller:contained withIndexPath:indexPath];
    UITableViewCell *cell = [contained.tableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id<TKRTableViewContained> contained = [self controllerAtIndex:section];

    if ([contained.tableViewDataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
          return [contained.tableViewDataSource tableView:tableView titleForHeaderInSection:0];
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    id<TKRTableViewContained> contained = [self controllerAtIndex:section];

    if ([contained.tableViewDataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
          return [contained.tableViewDataSource tableView:tableView titleForFooterInSection:0];
    }
    return nil;
}

//----------------------------------------------------------------------------//
#pragma mark - UITableViewDelegate
//----------------------------------------------------------------------------//

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<TKRTableViewContained> contained = [self controllerAtIndex:indexPath.section];
    indexPath = [self tableView:tableView indexPathForContainedControlller:contained withIndexPath:indexPath];
    if ([contained.tableViewDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [contained.tableViewDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<TKRTableViewContained> contained = [self controllerAtIndex:indexPath.section];
    NSIndexPath *replacedIndexPath;
    replacedIndexPath = [self tableView:tableView indexPathForContainedControlller:contained withIndexPath:indexPath];
    if ([contained.tableViewDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:needDeselect:)]) {
        BOOL needDeselect = NO;
        [(id)contained.tableViewDelegate tableView:tableView
                           didSelectRowAtIndexPath:replacedIndexPath
                                      needDeselect:(BOOL *)&needDeselect];
        if (needDeselect) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    } else if ([contained.tableViewDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [contained.tableViewDelegate tableView:tableView didSelectRowAtIndexPath:replacedIndexPath];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    id<TKRTableViewContained> contained = [self controllerAtIndex:section];

    if ([contained respondsToSelector:@selector(loadContentsWithCompletion:)]) {
        [contained loadContentsWithCompletion:^{
            if (NO == self.isDisappearing) {
                [tableView reloadData];
            }
        }];
    }

    if ([contained.tableViewDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
          return [contained.tableViewDelegate tableView:tableView viewForHeaderInSection:0];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0.0;
    id<TKRTableViewContained> contained = [self controllerAtIndex:section];

    if ([contained.tableViewDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
          height = [contained.tableViewDelegate tableView:tableView heightForHeaderInSection:0];
    }

    BOOL heightIsNotAssign = (0.0 == height);
    if (heightIsNotAssign) {
        if ([contained respondsToSelector:@selector(loadContentsWithCompletion:)]) {
            [contained loadContentsWithCompletion:^{
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
                if (NO == self.isDisappearing) {
                    [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }];
        }
    }

    return height;
}

//----------------------------------------------------------------------------//
#pragma mark - Private Methods
//----------------------------------------------------------------------------//

- (NSIndexPath *)tableView:(UITableView *)tableView
    indexPathForContainedControlller:(id<TKRTableViewContained>)contained
                       withIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = 0;
    NSUInteger row = indexPath.row;
    NSUInteger numberOfSections = 1;
    if ([contained.tableViewDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        numberOfSections = [contained.tableViewDataSource numberOfSectionsInTableView:tableView];
    }
    NSUInteger numberOfRowsInSection;
    numberOfRowsInSection = [contained.tableViewDataSource tableView:tableView numberOfRowsInSection:section];
    while (row >= numberOfRowsInSection && section < numberOfSections) {
        ++section;
        row -= numberOfRowsInSection;
        numberOfRowsInSection = [contained.tableViewDataSource tableView:tableView numberOfRowsInSection:section];
    }
    return [NSIndexPath indexPathForRow:row inSection:section];
}

@end
