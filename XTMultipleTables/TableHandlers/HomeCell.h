//
//  HomeCell.h
//  XTMultipleTables
//
//  Created by TuTu on 15/12/7.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *Identifier_home = @"HomeCell" ;

@interface HomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb_name;
@property (weak, nonatomic) IBOutlet UIImageView *img;
+ (CGFloat)getCellHeightWithCustomObj:(id)obj ;
@end
