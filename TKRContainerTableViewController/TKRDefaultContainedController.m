//
//  TKRDefaultContainedController.m
//
//  Created by ToKoRo on 2014-01-28.
//

#import "TKRDefaultContainedController.h"

@implementation TKRDefaultContainedController
    
//----------------------------------------------------------------------------//
#pragma mark - TKRTableViewContained
//----------------------------------------------------------------------------//
    
- (id<UITableViewDataSource>)tableViewDataSource
{
    return self;
}

- (id<UITableViewDelegate>)tableViewDelegate
{
    return self;
}

- (void)loadContentsWithCompletion:(void (^)(void))completion
{
}

//----------------------------------------------------------------------------//
#pragma mark - UITableViewDataSource
//----------------------------------------------------------------------------//

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                  reuseIdentifier:NSStringFromClass([self class])];
}

@end
