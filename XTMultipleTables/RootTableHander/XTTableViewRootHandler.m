//
//  XTTableViewRootHandler.m
//  XTMultipleTables
//
//  Created by TuTu on 15/12/7.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "XTTableViewRootHandler.h"

@interface XTTableViewRootHandler ()
@end

@implementation XTTableViewRootHandler

- (instancetype)initWithDataList:(NSArray *)datalist
                           table:(UITableView *)table
{
    self = [super init];
    if (self) {
        self.dataList = datalist ;
        [self handleTableDatasourceAndDelegate:table] ;
    }
    return self;
}

- (instancetype)initWithDataList:(NSArray *)datalist
{
    self = [super init];
    if (self) {
        self.dataList = datalist ;
    }
    return self;
}

- (void)handleTableDatasourceAndDelegate:(UITableView *)table
{
    table.dataSource = self ;
    table.delegate = self ;

    [table setNeedsLayout] ;
}

- (void)refreshOffsetYWithTable:(UITableView *)table
{
    CGPoint offset = table.contentOffset ;
    offset.y = self.offsetY ;
    table.contentOffset = offset ;
}


/*
 * Rewrite these functions .
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
*/

@end
