//
//  TaskDetailsViewController.m
//  ToDoApp
//
//  Created by Slsabel Hesham on 21/04/2024.
//

#import "TaskDetailsViewController.h"
#import "ViewController.h"
#import "Task.h"
@interface TaskDetailsViewController ()

@end

@implementation TaskDetailsViewController
NSString *selectedDate;
NSString *priority;
NSString *status;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"test" style:UIBarButtonItemStylePlain target:nil action:nil];
 //   [[self navigationItem] setBackBarButtonItem: backButton];
    self.navigationController.navigationBar.topItem.title = @"";

    self.taskView.layer.cornerRadius = 25.0;
    _date.minimumDate=[NSDate date];
    _addAndEditBtn.layer.cornerRadius = 20.0;
    _addAndEditBtn.backgroundColor = UIColor.systemGray2Color;
    if(self.currentTask.title != nil){
        _titleTV.text = _currentTask.title;
        _descTV.text = _currentTask.desc;
        if([_currentTask.priority isEqualToString:(@"low")]){
            priority = @"low";
            _priorityImage.image = [UIImage imageNamed:@"lowpriority.png"];
            _priority.selectedSegmentIndex = 0;
        }else if([_currentTask.priority isEqualToString:(@"medium")]){
            priority = @"medium";
            _priorityImage.image = [UIImage imageNamed:@"mediumpriority.png"];
            _priority.selectedSegmentIndex = 1;
        }else{
            priority = @"high";
            _priorityImage.image = [UIImage imageNamed:@"highpriority.png"];
            _priority.selectedSegmentIndex = 2;
        }
        if([_currentTask.status isEqualToString:(@"todo")]){
            status = @"todo";
            _status.selectedSegmentIndex = 0;
        }else if([_currentTask.status isEqualToString:(@"inprogress")]){
            status = @"inprogress";
            _status.selectedSegmentIndex = 1;
            [_status setEnabled:NO forSegmentAtIndex:0];

        }else if([_currentTask.status isEqualToString:(@"done")]){
            status = @"done";
            _titleTV.enabled = NO;
            _descTV.enabled = NO;
            _status.selectedSegmentIndex = 2;
            [_status setEnabled:NO forSegmentAtIndex:0];
            [_status setEnabled:NO forSegmentAtIndex:1];
            NSInteger selectedIndex = _priority.selectedSegmentIndex;
            for (NSInteger i = 0; i < _priority.numberOfSegments; i++) {
                if (i != selectedIndex) {
                    [_priority setEnabled:NO forSegmentAtIndex:i];
                }
            }
            _date.userInteractionEnabled = NO;
            _addAndEditBtn.hidden = YES;

        }
        _date.selected = _currentTask.date;
        [_headerLabel setText:@"Edit Task"];
        [_addAndEditBtn setTitle:@"Edit" forState:UIControlStateNormal];
    }else{
        priority = @"low";
        _priorityImage.image = [UIImage imageNamed:@"lowpriority.png"];

        status = @"todo";
        [_status setEnabled:NO forSegmentAtIndex:1];
        [_status setEnabled:NO forSegmentAtIndex:2];

    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)taskStatus:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            status=@"todo";
            printf("todo");

            break;
            
        case 1:
            status=@"inprogress";
            printf("inprogress");
            break;
        
        case 2:
            status=@"done";
            printf("done");

            break;
        
        default:
            break;
    }
}

- (IBAction)taskPriority:(UISegmentedControl *)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            priority=@"low";
            printf("low");
            _priorityImage.image = [UIImage imageNamed:@"lowpriority.png"];

            break;
            
        case 1:
            priority=@"medium";
            printf("med");
            _priorityImage.image = [UIImage imageNamed:@"mediumpriority.png"];

            break;
        
        case 2:
            priority=@"high";
            printf("high");
            _priorityImage.image = [UIImage imageNamed:@"highpriority.png"];

            break;
        
        default:
            break;
    }
}
- (IBAction)addTask:(UIButton *)sender {
    NSString *title = _addAndEditBtn.titleLabel.text;
    if([title isEqualToString:@"Add"]){
        if ([selectedDate compare:[NSDate date]] == NSOrderedDescending) {
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"Date" message:@"Pick a future date." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok= [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            [alertCon addAction:ok];
            [self presentViewController:alertCon animated:YES completion:NULL];
        } else if (_titleTV.text.length > 0 && _descTV.text.length) {
            [self showAddConfirmationAlert];
        } else {
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"Complete Information" message:@"Please complete all fields" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok= [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            [alertCon  addAction:ok];
            [self presentViewController:alertCon animated:YES completion:NULL];
        }
    } else {
        [self showEditConfirmationAlert];
    }
}

- (void)showAddConfirmationAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Task Confirmation" message:@"Are you sure you want to add this task?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self addTaskToUserDefaults];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:addAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showEditConfirmationAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Edit Task Confirmation" message:@"Are you sure you want to edit this task?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *editAction = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self editTaskInUserDefaults];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:editAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)addTaskToUserDefaults {
    Task *t1 = [Task new];
    [t1 setDate:self.date.date];
    [t1 initTaskWithTitle:_titleTV.text description:_descTV.text priority:priority status:status date:_date.date];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *tasksData = [defaults objectForKey:@"AllTasks"];
    NSMutableArray<Task *> *myTasks;
    
    if (tasksData) {
        myTasks = [NSKeyedUnarchiver unarchiveObjectWithData:tasksData];
        if (!myTasks) {
            myTasks = [NSMutableArray new];
        }
    } else {
        myTasks = [NSMutableArray new];
    }
    
    [myTasks addObject:t1];
    NSData *updatedTasksData = [NSKeyedArchiver archivedDataWithRootObject:myTasks];
    [defaults setObject:updatedTasksData forKey:@"AllTasks"];
    [defaults synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)editTaskInUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *tasksData = [defaults objectForKey:@"AllTasks"];
    NSMutableArray<Task *> *allTasks;
    
    if (tasksData) {
        allTasks = [NSKeyedUnarchiver unarchiveObjectWithData:tasksData];
        if (!allTasks) {
            allTasks = [NSMutableArray new];
        }
    } else {
        allTasks = [NSMutableArray new];
    }
    
    NSUInteger index = [allTasks indexOfObjectPassingTest:^BOOL(Task *task, NSUInteger idx, BOOL *stop) {
        return [task.title isEqualToString:_currentTask.title]
        && [task.desc isEqualToString:_currentTask.desc]
        && [task.priority isEqualToString:_currentTask.priority]
        && [task.status isEqualToString:_currentTask.status]
        && [task.date isEqualToDate:_currentTask.date];
    }];
    
    if (index != NSNotFound) {
        Task *mutableCurrentTask = [Task new];
        mutableCurrentTask.title = _titleTV.text;
        mutableCurrentTask.desc = _descTV.text;
        mutableCurrentTask.date = _date.date;
        mutableCurrentTask.priority = priority;
        mutableCurrentTask.status = status;
        
        [allTasks replaceObjectAtIndex:index withObject:mutableCurrentTask];
        
        NSData *updatedTasksData = [NSKeyedArchiver archivedDataWithRootObject:allTasks];
        [defaults setObject:updatedTasksData forKey:@"AllTasks"];
        [defaults synchronize];
    } else {
        NSLog(@"_currentTask not found in allTasks array");
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
