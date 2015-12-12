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

@protocol XTMultipleTablesDelegate <NSObject>
- (void)moveToIndexCallBack:(int)index ;
@end

@interface XTMultipleTables : UIScrollView

@property (nonatomic, weak) id <XTMultipleTablesDelegate> xtDelegate ;
@property (nonatomic,readonly) int currentIndex ;
- (void)xtMultipleTableMoveToTheIndex:(int)indexToMove ;

- (instancetype)initWithFrame:(CGRect)frame
                     handlers:(NSArray *)handlersList ;

@end
