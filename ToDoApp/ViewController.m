//
//  ViewController.m
//  ToDoApp
//
//  Created by Slsabel Hesham on 21/04/2024.
//

#import "ViewController.h"
#import "TaskDetailsViewController.h"
#import "MyTableViewCell.h"
@interface ViewController ()

@end
//NSMutableArray<Task *> *allTasks;
NSMutableArray<Task *> *todoTasks;
NSMutableArray<Task *> *lowArray;
NSMutableArray<Task *> *mediumArray ;
NSMutableArray<Task *> *highArray;

NSMutableArray <Task*> *tasks;
@implementation ViewController
static NSMutableArray *inProgressTasks;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"AllTasks"];
    tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.filteredTasks = [tasks mutableCopy];

    
    [self filterArrayStatus];
    [self filterArrayPriority];
    [self.tasksTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    switch (section) {
        case 0:
            count = [lowArray count];
            break;
        case 1:
            count = [mediumArray count];
            break;
        case 2:
            count = [highArray count];
            break;
        default:
            break;
    }
    return count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.search.delegate = self;
    //allTasks = [NSMutableArray new];
    todoTasks = [NSMutableArray new];
    lowArray = [NSMutableArray new];
    mediumArray = [NSMutableArray new];
    highArray = [NSMutableArray new];

    _isSearching = NO;
    
    self.search.delegate = self;
    self.tasksTable.dataSource = self;
    self.tasksTable.delegate = self;
    _dashbboard.layer.cornerRadius = 15.0;
    _addTask.layer.cornerRadius = 30.0;
    

}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        _isSearching = NO;
    } else {
        _isSearching = YES;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[c] %@", searchText];
        self.filteredTasks = [[todoTasks filteredArrayUsingPredicate:predicate] mutableCopy];
    }
    [self filterArrayPriority];
    [self.tasksTable reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    _isSearching = NO;
    [self searchBar:searchBar textDidChange:@""];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddTaskSegue"]) {
        TaskDetailsViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.vc = self;
    }else if ([segue.identifier isEqualToString:@"editTask"]) {
        TaskDetailsViewController *editTaskVC = segue.destinationViewController;
        
        NSIndexPath *selectedIndexPath = [self.tasksTable indexPathForSelectedRow];
        
        NSInteger section = selectedIndexPath.section;
        
        NSInteger row = selectedIndexPath.row;
        if (section == 0) {
            editTaskVC.currentTask = lowArray[row];
        } else if (section == 1) {
            editTaskVC.currentTask = mediumArray[row];
        } else if (section == 2) {
            editTaskVC.currentTask = highArray[row];
        }
        editTaskVC.source = @"todo";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0;
}
- (void)filterArrayPriority {
    if(_isSearching == NO){
        [lowArray removeAllObjects];
        [mediumArray removeAllObjects];
        [highArray removeAllObjects];
        for (Task *task in todoTasks) {
            if ([task.priority isEqualToString:@"low"]) {
                [lowArray addObject:task];
            } else if ([task.priority isEqualToString:@"medium"]) {
                [mediumArray addObject:task];
            } else if ([task.priority isEqualToString:@"high"]) {
                [highArray addObject:task];
            }
        }
    }else{
        [lowArray removeAllObjects];
        [mediumArray removeAllObjects];
        [highArray removeAllObjects];
        for (Task *task in _filteredTasks) {
            if ([task.priority isEqualToString:@"low"]) {
                [lowArray addObject:task];
            } else if ([task.priority isEqualToString:@"medium"]) {
                [mediumArray addObject:task];
            } else if ([task.priority isEqualToString:@"high"]) {
                [highArray addObject:task];
            }
        }
    }
    
}
- (void)filterArrayStatus {
        [todoTasks removeAllObjects];
        printf("1\n");
    for (Task *task in tasks) {
        printf("2\n");
        if ([task.status isEqualToString:@"todo"]) {
            printf("3\n");
            [todoTasks addObject:task];
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"task" forIndexPath:indexPath];
    cell.layer.cornerRadius = 20;
    cell.layer.borderWidth = 5;

    cell.layer.borderColor = UIColor.grayColor.CGColor;
    
    
    // Configure the cell
    switch (indexPath.section) {
        case 0: {
            cell.myCellLabel.text = [[lowArray objectAtIndex:indexPath.row] title];
            
            NSDate *date = [[lowArray objectAtIndex:indexPath.row] date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd-MM-YYYY"];
            NSString *dateString = [formatter stringFromDate:date];
            cell.dateLabel.text = dateString;
            
            cell.myCellImage.image = [UIImage imageNamed:@"lowpriority.png"];

        }
            break;
        
        case 1:{
            cell.myCellLabel.text = [[mediumArray objectAtIndex:indexPath.row] title];
            NSDate *date = [[mediumArray objectAtIndex:indexPath.row] date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd-MM-YYYY"];
            NSString *dateString = [formatter stringFromDate:date];
            cell.dateLabel.text = dateString;
            cell.myCellImage.image = [UIImage imageNamed:@"mediumpriority.png"];

        }
            break;
        case 2:{
            cell.myCellLabel.text = [[highArray objectAtIndex:indexPath.row] title];
            NSDate *date = [[highArray objectAtIndex:indexPath.row] date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd-MM-YYYY"];
            NSString *dateString = [formatter stringFromDate:date];
            cell.dateLabel.text = dateString;
            cell.myCellImage.image = [UIImage imageNamed:@"highpriority.png"];

        }
            break;
            
        default:
            break;
    }
    
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

- (void)deleteTaskAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *tasksData = [defaults objectForKey:@"AllTasks"];
    
    tasks = [NSKeyedUnarchiver unarchiveObjectWithData:tasksData];
    
    NSUInteger indexToDelete = indexPath.row;
    [tasks removeObjectAtIndex:indexToDelete];
    
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:tasks] forKey:@"AllTasks"];
    [defaults synchronize];
    
    
    [self filterArrayStatus];
    [self filterArrayPriority];
    [self.tasksTable reloadData];
}
@end
