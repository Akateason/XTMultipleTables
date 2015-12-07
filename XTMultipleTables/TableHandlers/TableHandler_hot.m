//
//  TableHandler_hot.m
//  XTMultipleTables
//
//  Created by TuTu on 15/12/7.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "TableHandler_hot.h"
#import "HotPointCell.h"

@implementation TableHandler_hot

/*
 * Rewrite these functions .
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotPointCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierHotPoint] ;
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:identifierHotPoint bundle:nil] forCellReuseIdentifier:identifierHotPoint] ;
        cell = [tableView dequeueReusableCellWithIdentifier:identifierHotPoint];
    }
    cell.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row % 5 + 1]] ;
    cell.lb.text = [NSString stringWithFormat:@"呵呵哒 : %@",self.dataList[indexPath.row]] ;
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0f ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"click HotPoint page row : %@",@(indexPath.row)) ;
}

@end
