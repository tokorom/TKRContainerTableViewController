//
//  TKRTableViewContained.h
//
//  Created by ToKoRo on 2014-01-23.
//

@class TKRContainerTableViewController;

@protocol TKRTableViewContained<NSObject>

@required

- (id<UITableViewDataSource>)tableViewDataSource;
- (id<UITableViewDelegate>)tableViewDelegate;

@optional

- (void)willAppearWithTableView:(UITableView *)tableView;
- (void)setParentViewController:(TKRContainerTableViewController *)parentViewController;
- (void)loadContentsWithCompletion:(void (^)(void))completion;

@end 

@interface NSObject (TKRTableViewContained)
// optional delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath needDeselect:(BOOL *)needDeselect;
@end
