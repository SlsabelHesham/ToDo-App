//
//  ViewController.h
//  ToDoApp
//
//  Created by Slsabel Hesham on 21/04/2024.
//

#import <UIKit/UIKit.h>
#import "Task.h"

//static NSMutableArray<Task *> *allTasks ;

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIView *dashbboard;
@property (weak, nonatomic) IBOutlet UIButton *addTask;

@property BOOL isSearching;
@property (nonatomic, strong) NSMutableArray<Task *> *filteredTasks;
@property (weak, nonatomic) IBOutlet UITableView *tasksTable;
@property (weak, nonatomic) IBOutlet UISearchBar *search;


@end

