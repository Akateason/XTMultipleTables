//
//  EntertainmentCell.m
//  XTMultipleTables
//
//  Created by TuTu on 15/12/7.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "EntertainmentCell.h"

@implementation EntertainmentCell

+ (float)getHeight
{
    return 130.0 ;
}

- (void)awakeFromNib {
    // Initialization code
    _img.layer.masksToBounds = YES ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
