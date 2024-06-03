//
//  TaskDetailsViewController.h
//  ToDoApp
//
//  Created by Slsabel Hesham on 21/04/2024.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIView *taskView;
@property (weak, nonatomic) IBOutlet UIImageView *priorityImage;
@property (weak, nonatomic) IBOutlet UITextField *titleTV;
@property (weak, nonatomic) IBOutlet UITextField *descTV;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;
@property (weak, nonatomic) IBOutlet UIDatePicker *date;
@property (weak, nonatomic) IBOutlet UISegmentedControl *status;
- (IBAction)addTask:(UIButton *)sender;
- (IBAction)taskPriority:(UISegmentedControl *)sender;
- (IBAction)taskStatus:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addAndEditBtn;

@property ViewController *vc;
@property Task *currentTask;
@property NSString *source;

@end

NS_ASSUME_NONNULL_END
