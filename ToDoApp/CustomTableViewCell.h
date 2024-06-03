//
//  CustomTableViewCell.h
//  ToDoApp
//
//  Created by Slsabel Hesham on 24/04/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *cellLavel;

@end

NS_ASSUME_NONNULL_END
