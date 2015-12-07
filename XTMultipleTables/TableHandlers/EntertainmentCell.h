//
//  EntertainmentCell.h
//  XTMultipleTables
//
//  Created by TuTu on 15/12/7.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *identifier_Entertainment = @"EntertainmentCell" ;

@interface EntertainmentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;

+ (float)getHeight ;

@end
