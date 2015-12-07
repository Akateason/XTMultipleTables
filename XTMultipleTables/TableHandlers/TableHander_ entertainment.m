//
//  TableHander_ entertainment.m
//  XTMultipleTables
//
//  Created by TuTu on 15/12/7.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "TableHander_ entertainment.h"
#import "EntertainmentCell.h"

@implementation TableHander__entertainment

/*
 * Rewrite these functions .
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EntertainmentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_Entertainment] ;
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:identifier_Entertainment bundle:nil] forCellReuseIdentifier:identifier_Entertainment] ;
        cell = [tableView dequeueReusableCellWithIdentifier:identifier_Entertainment];
    }
    cell.img.image = indexPath.row % 2 ? [UIImage imageNamed:@"img1"] : [UIImage imageNamed:@"img2"] ;
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [EntertainmentCell getHeight] ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"click Entertainment page row : %@",@(indexPath.row)) ;
}


@end
