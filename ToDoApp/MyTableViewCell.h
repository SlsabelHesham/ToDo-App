//
//  MyTableViewCell.h
//  ToDoApp
//
//  Created by Slsabel Hesham on 24/04/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myCellImage;
@property (weak, nonatomic) IBOutlet UILabel *myCellLabel;

@end

NS_ASSUME_NONNULL_END
