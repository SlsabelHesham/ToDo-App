//
//  InProgressViewController.h
//  ToDoApp
//
//  Created by Slsabel Hesham on 21/04/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InProgressViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *inprogressTable;

@end

NS_ASSUME_NONNULL_END
