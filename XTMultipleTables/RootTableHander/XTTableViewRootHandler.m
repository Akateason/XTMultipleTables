//
//  XTTableViewRootHandler.m
//  XTMultipleTables
//
//  Created by TuTu on 15/12/7.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "XTTableViewRootHandler.h"

@interface XTTableViewRootHandler () <UITableViewDataSource,UITableViewDelegate>
@end

@implementation XTTableViewRootHandler

#pragma mark --
#pragma mark - Initialization
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

#pragma mark --
#pragma mark - Public
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

#pragma mark --
#pragma mark - UITableViewDataSource,UITableViewDelegate
/*
 * Rewrite these functions below .
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tempIdentifier = @"cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tempIdentifier] ;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tempIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"temp : %@",@(indexPath.row)] ;

    UIColor *color1 = [UIColor magentaColor] ;
    UIColor *color2 = [UIColor whiteColor] ;
    
    cell.backgroundColor = indexPath.row % 2 ? color1 : color2 ;
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
