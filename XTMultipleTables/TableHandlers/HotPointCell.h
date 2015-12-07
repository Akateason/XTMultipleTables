//
//  HotPointCell.h
//  XTMultipleTables
//
//  Created by TuTu on 15/12/7.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *identifierHotPoint = @"HotPointCell" ;

@interface HotPointCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (weak, nonatomic) IBOutlet UISwitch *bOpen;

@end
