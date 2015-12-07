//
//  XTTableViewRootHandler.h
//  XTMultipleTables
//
//  Created by TuTu on 15/12/7.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XTTableViewRootHandler : NSObject <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *dataList ;    // datasource
@property (nonatomic)        CGFloat offsetY ;      // cache offsetY .

- (instancetype)initWithDataList:(NSArray *)datalist ;
- (instancetype)initWithDataList:(NSArray *)datalist table:(UITableView *)table ;

- (void)handleTableDatasourceAndDelegate:(UITableView *)table ;
- (void)refreshOffsetYWithTable:(UITableView *)table ;

@end
