//
//  TKRDefaultContainedController.h
//
//  Created by ToKoRo on 2014-01-28.
//

#import "TKRTableViewContained.h"
#import "TKRContainerTableViewController.h"

@interface TKRDefaultContainedController : NSObject
<
    TKRTableViewContained,
    UITableViewDataSource,
    UITableViewDelegate
>

@property (weak) TKRContainerTableViewController *parentViewController;

@end
