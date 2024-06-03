//
//  InProgressViewController.m
//  ToDoApp
//
//  Created by Slsabel Hesham on 21/04/2024.
//

#import "InProgressViewController.h"
#import "Task.h"
#import "TaskDetailsViewController.h"
#import "MyTableViewCell.h"
@interface InProgressViewController ()

@end
NSArray<Task *> *allTasksArray;
NSMutableArray <Task*> *progressTasks;

@implementation InProgressViewController{
    
    NSMutableArray<Task *> *inprogressTasks;
    NSMutableArray<Task *> *inProgresslowArray;
    NSMutableArray<Task *> *inProgressmediumArray ;
    NSMutableArray<Task *> *inProgresshighArray;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"AllTasks"];
    progressTasks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    printf("my %lu", (unsigned long)progressTasks.count);
    //printf("myyy %s\n", [[progressTasks objectAtIndex:0] title].UTF8String);
    /*
     NSData *tasksData = [[NSUserDefaults standardUserDefaults] objectForKey:@"AllTasks"];
    if (tasksData) {
        allTasks = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSArray class] fromData:tasksData error:nil];
        printf("tasks data \n");
        printf("task %lu\n", (unsigned long)allTasks.count);
    } else {
        printf("no data\n");
    }*/
    [self filterArrayStatus];
    [self filterArrayPriority];
    [self.inprogressTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    switch (section) {
        case 0:
            count = [inProgresslowArray count];
            break;
        case 1:
            count = [inProgressmediumArray count];
            break;
        case 2:
            count = [inProgresshighArray count];
            break;
        default:
            break;
    }
    return count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.search.delegate = self;
    inprogressTasks = [NSMutableArray new];
    inProgresslowArray = [NSMutableArray new];
    inProgressmediumArray = [NSMutableArray new];
    inProgresshighArray = [NSMutableArray new];

    self.inprogressTable.dataSource = self;
    self.inprogressTable.delegate = self;
    
    [self filterArrayStatus];
    [self filterArrayPriority];
    printf("%lu\n", (unsigned long)inprogressTasks.count);
    [self.inprogressTable reloadData];
    
    NSData *tasksData = [[NSUserDefaults standardUserDefaults] objectForKey:@"AllTasks"];
    if (tasksData) {
        allTasksArray = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSArray class] fromData:tasksData error:nil];
    } else {
        // Handle the case where no tasks are stored in UserDefaults
    }
 
}
 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"inprogress"]) {
        TaskDetailsViewController *editTaskVC = segue.destinationViewController;
        
        NSIndexPath *selectedIndex = [self.inprogressTable indexPathForSelectedRow];
        
        NSInteger section = selectedIndex.section;
        
        NSInteger row = selectedIndex.row;
        if (section == 0) {
            editTaskVC.currentTask = inProgresslowArray[row];
        } else if (section == 1) {
            editTaskVC.currentTask = inProgressmediumArray[row];
        } else if (section == 2) {
            editTaskVC.currentTask = inProgresshighArray[row];
        }
        editTaskVC.source = @"inprogress";
    }
}

- (void)filterArrayPriority {
    [inProgresslowArray removeAllObjects];
    [inProgressmediumArray removeAllObjects];
    [inProgresshighArray removeAllObjects];
    for (Task *task in inprogressTasks) {
       // printf("%s\n",toDoTasks[0].title);
        if ([task.priority isEqualToString:@"low"]) {
            [inProgresslowArray addObject:task];
        } else if ([task.priority isEqualToString:@"medium"]) {
            [inProgressmediumArray addObject:task];
        } else if ([task.priority isEqualToString:@"high"]) {
            [inProgresshighArray addObject:task];
        }
    }
}
- (void)filterArrayStatus {
    [inprogressTasks removeAllObjects];
    printf("test method %lu\n", (unsigned long)progressTasks.count);
    for (Task *task in progressTasks) {
        printf("test");
        if ([task.status isEqualToString:@"inprogress"]) {
            [inprogressTasks addObject:task];
            printf("enterr");
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inprogressCell" forIndexPath:indexPath];
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inprogressCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 20;
    cell.layer.borderWidth = 5;

    cell.layer.borderColor = UIColor.whiteColor.CGColor;
    switch (indexPath.section) {
        case 0: {
            cell.myCellLabel.text = [[inProgresslowArray objectAtIndex:indexPath.row] title];
            
            NSDate *date = [[inProgresslowArray objectAtIndex:indexPath.row] date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd-MM-YYYY"];
            NSString *dateString = [formatter stringFromDate:date];
            cell.dateLabel.text = dateString;
            
            cell.myCellImage.image = [UIImage imageNamed:@"lowpriority.png"];

        }
            break;
        
        case 1:{
            cell.myCellLabel.text = [[inProgressmediumArray objectAtIndex:indexPath.row] title];
            NSDate *date = [[inProgressmediumArray objectAtIndex:indexPath.row] date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd-MM-YYYY"];
            NSString *dateString = [formatter stringFromDate:date];
            cell.dateLabel.text = dateString;
            cell.myCellImage.image = [UIImage imageNamed:@"mediumpriority.png"];

        }
            break;
        case 2:{
            cell.myCellLabel.text = [[inProgresshighArray objectAtIndex:indexPath.row] title];
            NSDate *date = [[inProgresshighArray objectAtIndex:indexPath.row] date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd-MM-YYYY"];
            NSString *dateString = [formatter stringFromDate:date];
            cell.dateLabel.text = dateString;
            cell.myCellImage.image = [UIImage imageNamed:@"highpriority.png"];

        }
            break;
        default:
            break;
    }/*
    if([inprogressTasks count] > 0){
        cell.textLabel.text = [[inprogressTasks objectAtIndex:indexPath.row] title];
    }else{
        printf("ssss\n");

    }
 */
    return cell;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *sectionTitles = @[@"Low Priority", @"Medium Priority", @"High Priority"];

    return sectionTitles[section];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Confirm Deletion" message:@"Are you sure you want to delete this task?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self deleteTaskAtIndexPath:indexPath];
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:deleteAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0;
}
- (void)deleteTaskAtIndexPath:(NSIndexPath *)indexPath {
    // Your existing delete logic here
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *tasksData = [defaults objectForKey:@"AllTasks"];
    
    progressTasks = [NSKeyedUnarchiver unarchiveObjectWithData:tasksData];
    
    NSUInteger indexToDelete = indexPath.row;
    [progressTasks removeObjectAtIndex:indexToDelete];
    
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:progressTasks] forKey:@"AllTasks"];
    [defaults synchronize];
    
    
    [self filterArrayStatus];
    [self filterArrayPriority];
    [self.inprogressTable reloadData];
}
@end
