//
//  XTMultipleTables.h
//  XTMultipleTables
//
//  Created by TuTu on 15/12/4.
//  Copyright © 2015年 teason. All rights reserved.
//
#define APPFRAME                        [UIScreen mainScreen].bounds

#import <UIKit/UIKit.h>
@class XTTableDataDelegate ;

@interface XTMultipleTables : UIScrollView

@property (nonatomic)   int currentIndex ;

- (instancetype)initWithFrame:(CGRect)frame
                     handlers:(NSArray *)handlersList ;

@end
