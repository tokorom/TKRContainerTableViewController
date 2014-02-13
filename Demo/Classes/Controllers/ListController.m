//
//  ListController.m
//
//  Created by ToKoRo on 2014-02-12.
//

#import "ListController.h"

static NSString * const kCellIdentifier = @"ListCell";

@implementation ListController
    
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
    return NSLocalizedString(@"LIST", nil);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"list %lu", indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"Dog"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

//----------------------------------------------------------------------------//
#pragma mark - UITableViewDelegate
//----------------------------------------------------------------------------//

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

@end
