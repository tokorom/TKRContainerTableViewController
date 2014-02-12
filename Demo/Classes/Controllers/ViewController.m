//
//  ViewController.m
//
//  Created by ToKoRo on 2014-02-12.
//

#import "ViewController.h"
#import "PickupController.h"
#import "ListController.h"

@implementation ViewController

//----------------------------------------------------------------------------//
#pragma mark - View lifecycle
//----------------------------------------------------------------------------//

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0);

    [self addController:[PickupController new]];
    [self addController:[ListController new]];
    [self addController:[ListController new]];
    [self addController:[ListController new]];
}
    
@end
