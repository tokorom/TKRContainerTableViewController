//
//  PickupController.m
//
//  Created by ToKoRo on 2014-02-12.
//

#import "PickupController.h"

static NSString * const kCellIdentifier = @"PickupCell";

@implementation PickupController

//----------------------------------------------------------------------------//
#pragma mark - Lifecycle
//----------------------------------------------------------------------------//

- (void)willAppearWithTableView:(UITableView *)tableView
{
    UINib *nib = [UINib nibWithNibName:kCellIdentifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:kCellIdentifier];
}

//----------------------------------------------------------------------------//
#pragma mark - UITableViewDataSource
//----------------------------------------------------------------------------//

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NSLocalizedString(@"PICKUP", nil);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//----------------------------------------------------------------------------//
#pragma mark - UITableViewDelegate
//----------------------------------------------------------------------------//

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

@end
