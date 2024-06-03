//
//  Task.h
//  ToDoApp
//
//  Created by Slsabel Hesham on 21/04/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject <NSCoding, NSSecureCoding>
@property NSString *title;
@property NSString *desc;
@property NSString *priority;
@property NSString *status;
@property NSDate *date;
 
- (void)initTaskWithTitle:(NSString *)title
            description:(NSString *)desc
               priority:(NSString *)priority
                 status:(NSString *)status
                     date:(NSDate *)date ;
-(void) encodeWithCoder:(NSCoder *)coder;
@end

NS_ASSUME_NONNULL_END
