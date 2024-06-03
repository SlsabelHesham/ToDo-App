//
//  Task.m
//  ToDoApp
//
//  Created by Slsabel Hesham on 21/04/2024.
//

#import "Task.h"


@implementation Task

+ (BOOL)supportsSecureCoding {
    return YES;
}
- (void)initTaskWithTitle:(NSString *)title
            description:(NSString *)desc
               priority:(NSString *)priority
                 status:(NSString *)status
                   date:(NSDate *)date {
    self.title = title;
    self.desc = desc;
    self.priority = priority;
    self.status = status;
    self.date = date;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.desc forKey:@"desc"];
    [encoder encodeObject:self.priority forKey:@"priority"];
    [encoder encodeObject:self.status forKey:@"status"];
    [encoder encodeObject:self.date forKey:@"date"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.title = [decoder decodeObjectOfClass:[NSString class] forKey:@"title"];
        self.desc = [decoder decodeObjectOfClass:[NSString class] forKey:@"desc"];
        self.priority = [decoder decodeObjectOfClass:[NSString class] forKey:@"priority"];
        self.status = [decoder decodeObjectOfClass:[NSString class] forKey:@"status"];
        self.date = [decoder decodeObjectOfClass:[NSDate class] forKey:@"date"];
    }
    return self;
}

@end
