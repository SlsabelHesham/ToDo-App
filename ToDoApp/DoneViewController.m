//
//  DoneViewController.m
//  ToDoApp
//
//  Created by Slsabel Hesham on 21/04/2024.
//

#import "DoneViewController.h"
#import "Task.h"
#import "TaskDetailsViewController.h"
#import "MyTableViewCell.h"

@interface DoneViewController ()

@end

NSArray<Task *> *userDefaulttsArray;
NSMutableArray <Task*> *doneTasks;

@implementation DoneViewController{
    NSMutableArray<Task *> *allDoneTasks;
    NSMutableArray<Task *> *donelowArray;
    NSMutableArray<Task *> *donemediumArray ;
    NSMutableArray<Task *> *donehighArray;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"AllTasks"];
    doneTasks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    printf("my %lu", (unsigned long)doneTasks.count);
  //  printf("myyy %s\n", [[doneTasks objectAtIndex:0] title].UTF8String);
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
    [self.doneTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    switch (section) {
        case 0:
            count = [donelowArray count];
            break;
        case 1:
            count = [donemediumArray count];
            break;
        case 2:
            count = [donehighArray count];
            break;
        default:
            break;
    }
    return count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.search.delegate = self;
    allDoneTasks = [NSMutableArray new];
    donelowArray = [NSMutableArray new];
    donemediumArray = [NSMutableArray new];
    donehighArray = [NSMutableArray new];

    self.doneTable.dataSource = self;
    self.doneTable.delegate = self;
    
    [self filterArrayStatus];
    [self filterArrayPriority];
    printf("%lu\n", (unsigned long)allDoneTasks.count);
    [self.doneTable reloadData];
    
    NSData *tasksData = [[NSUserDefaults standardUserDefaults] objectForKey:@"AllTasks"];
    if (tasksData) {
        userDefaulttsArray = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSArray class] fromData:tasksData error:nil];
    } else {
        // Handle the case where no tasks are stored in UserDefaults
    }
 
}
 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"done"]) {
        TaskDetailsViewController *editTaskVC = segue.destinationViewController;
        
        NSIndexPath *selectedIndex = [self.doneTable indexPathForSelectedRow];
        
        NSInteger section = selectedIndex.section;
        
        NSInteger row = selectedIndex.row;
        if (section == 0) {
            editTaskVC.currentTask = donelowArray[row];
        } else if (section == 1) {
            editTaskVC.currentTask = donemediumArray[row];
        } else if (section == 2) {
            editTaskVC.currentTask = donehighArray[row];
        }
        editTaskVC.source = @"done";
    }
}

- (void)filterArrayPriority {
    [donelowArray removeAllObjects];
    [donemediumArray removeAllObjects];
    [donehighArray removeAllObjects];
    for (Task *task in allDoneTasks) {
       // printf("%s\n",toDoTasks[0].title);
        if ([task.priority isEqualToString:@"low"]) {
            [donelowArray addObject:task];
        } else if ([task.priority isEqualToString:@"medium"]) {
            [donemediumArray addObject:task];
        } else if ([task.priority isEqualToString:@"high"]) {
            [donehighArray addObject:task];
        }
    }
}
- (void)filterArrayStatus {
    [allDoneTasks removeAllObjects];
    printf("test method %lu\n", (unsigned long)doneTasks.count);
    for (Task *task in doneTasks) {
        printf("test");
        if ([task.status isEqualToString:@"done"]) {
            [allDoneTasks addObject:task];
            printf("enterr");
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doneCell" forIndexPath:indexPath];
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doneCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 20;
    cell.layer.borderWidth = 5;

    cell.layer.borderColor = UIColor.whiteColor.CGColor;
    switch (indexPath.section) {
        case 0: {
            cell.myCellLabel.text = [[donelowArray objectAtIndex:indexPath.row] title];
            
            NSDate *date = [[donelowArray objectAtIndex:indexPath.row] date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd-MM-YYYY"];
            NSString *dateString = [formatter stringFromDate:date];
            cell.dateLabel.text = dateString;
            
            cell.myCellImage.image = [UIImage imageNamed:@"lowpriority.png"];

        }
            break;
        
        case 1:{
            cell.myCellLabel.text = [[donemediumArray objectAtIndex:indexPath.row] title];
            NSDate *date = [[donemediumArray objectAtIndex:indexPath.row] date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd-MM-YYYY"];
            NSString *dateString = [formatter stringFromDate:date];
            cell.dateLabel.text = dateString;
            cell.myCellImage.image = [UIImage imageNamed:@"mediumpriority.png"];

        }
            break;
        case 2:{
            cell.myCellLabel.text = [[donehighArray objectAtIndex:indexPath.row] title];
            NSDate *date = [[donehighArray objectAtIndex:indexPath.row] date];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0;
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

- (void)deleteTaskAtIndexPath:(NSIndexPath *)indexPath {
    // Your existing delete logic here
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *tasksData = [defaults objectForKey:@"AllTasks"];
    
    doneTasks = [NSKeyedUnarchiver unarchiveObjectWithData:tasksData];
    
    NSUInteger indexToDelete = indexPath.row;
    [doneTasks removeObjectAtIndex:indexToDelete];
    
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:doneTasks] forKey:@"AllTasks"];
    [defaults synchronize];
    
    
    [self filterArrayStatus];
    [self filterArrayPriority];
    [self.doneTable reloadData];
}
@end
