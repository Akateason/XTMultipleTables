//
//  TableHandler_homePage.m
//  XTMultipleTables
//
//  Created by TuTu on 15/12/7.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "TableHandler_homePage.h"
#import "HomeCell.h"

@implementation TableHandler_homePage

/*
 * Rewrite these functions .
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_home] ;
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:Identifier_home bundle:nil] forCellReuseIdentifier:Identifier_home] ;
        cell = [tableView dequeueReusableCellWithIdentifier:Identifier_home];
    }
    cell.lb_name.text = self.dataList[indexPath.row] ;
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HomeCell getCellHeightWithCustomObj:nil] ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"click home page row : %@",@(indexPath.row)) ;
}

@end
