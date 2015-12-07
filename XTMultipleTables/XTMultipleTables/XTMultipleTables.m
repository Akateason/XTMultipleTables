//
//  XTMultipleTables.m
//  XTMultipleTables
//
//  Created by TuTu on 15/12/4.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "XTMultipleTables.h"
#import "XTTableViewRootHandler.h"

static int IMAGEVIEW_COUNT = 3 ;

@interface XTMultipleTables () <UIScrollViewDelegate>

@property (nonatomic,strong) UITableView *leftTable ;
@property (nonatomic,strong) UITableView *centerTable ;
@property (nonatomic,strong) UITableView *rightTable ;

@property (nonatomic)        int         allCount ;
@property (nonatomic,strong) NSArray     *list_handlers ; // Class `XTTableDataDelegate` objects list.

@end

@implementation XTMultipleTables

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame
                     handlers:(NSArray *)handlersList
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.list_handlers = handlersList ;
        [self setup] ;
    }
    return self;
}

- (void)setup
{
    [self configureScrollView] ;
    [self setupTables] ;
    [self setupDefaultTable] ;
}

- (void)configureScrollView
{
    self.delegate = self ;
    self.contentSize = CGSizeMake(IMAGEVIEW_COUNT * self.frame.size.width, self.frame.size.height) ;
    [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO] ;
    self.pagingEnabled = YES ;
    self.showsHorizontalScrollIndicator = NO ;
}

- (void)setupTables
{
    [self leftTable] ;
    [self centerTable] ;
    [self rightTable] ;
}

- (void)setupDefaultTable
{
    // set default center , left and right if needed .
    [(XTTableViewRootHandler *)_list_handlers[0] handleTableDatasourceAndDelegate:_centerTable] ;
    
    if (self.allCount > 1)
    {
        [(XTTableViewRootHandler *)_list_handlers[self.allCount - 1] handleTableDatasourceAndDelegate:_leftTable] ;
        [(XTTableViewRootHandler *)_list_handlers[1] handleTableDatasourceAndDelegate:_rightTable] ;
    }
    
    self.currentIndex = 0 ;
}

#pragma mark - Property
- (UITableView *)leftTable
{
    if (!_leftTable) {
        CGRect rectLeft = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) ;
        _leftTable = [[UITableView alloc] initWithFrame:rectLeft style:UITableViewStylePlain] ;
        _leftTable.separatorStyle = 0 ;
        if (![_leftTable superview]) {
            [self addSubview:_leftTable] ;
        }
    }
    return _leftTable ;
}

- (UITableView *)centerTable
{
    if (!_centerTable) {
        CGRect rectCenter = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) ;
        rectCenter.origin.x += rectCenter.size.width ;
        _centerTable = [[UITableView alloc] initWithFrame:rectCenter style:UITableViewStylePlain] ;
        _centerTable.separatorStyle = 0 ;
        if (![_centerTable superview]) {
            [self addSubview:_centerTable] ;
        }
    }
    return _centerTable ;
}

- (UITableView *)rightTable
{
    if (!_rightTable) {
        CGRect rectRight = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) ;
        rectRight.origin.x += (rectRight.size.width * 2) ;
        _rightTable = [[UITableView alloc] initWithFrame:rectRight style:UITableViewStylePlain] ;
        _rightTable.separatorStyle = 0 ;
        if (![_rightTable superview]) {
            [self addSubview:_rightTable] ;
        }
    }
    return _rightTable ;
}

- (int)allCount
{
    if (!_allCount && self.list_handlers != nil) {
        _allCount = (int)self.list_handlers.count ;
    }
    return _allCount ;
}

- (void)setList_handlers:(NSArray *)list_handlers
{
    _list_handlers = list_handlers ;
    
    self.scrollEnabled = (list_handlers.count > 1) ;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // cache tableview offset Y.
    ((XTTableViewRootHandler *)_list_handlers[_currentIndex]).offsetY = _centerTable.contentOffset.y ;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self refresh] ;
    [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO] ;
    [self resetOffsetYOfEveryTable] ;
}

#pragma mark - refresh .
- (void)refresh
{
    int leftIndex , rightIndex ;
    CGPoint offset = [self contentOffset] ;
    
//    NSLog(@"offset x : %@",@(offset.x)) ;
    if (offset.x > self.frame.size.width)
    {
    // scroll to left
        _currentIndex = (_currentIndex + 1) % self.allCount ;
    }
    else if(offset.x < self.frame.size.width)
    {
    // scroll to right
        _currentIndex = (_currentIndex + self.allCount - 1) % self.allCount ;
    }
    else
        return ;
    
    // reset handler of center .
    [(XTTableViewRootHandler *)_list_handlers[_currentIndex] handleTableDatasourceAndDelegate:_centerTable] ;
    // reset handler of left and right .
    leftIndex   = (_currentIndex + self.allCount - 1) % self.allCount ;
    rightIndex  = (_currentIndex + 1) % self.allCount ;
    [(XTTableViewRootHandler *)_list_handlers[leftIndex] handleTableDatasourceAndDelegate:_leftTable] ;
    [(XTTableViewRootHandler *)_list_handlers[rightIndex] handleTableDatasourceAndDelegate:_rightTable] ;
//    NSLog(@"currentIndex is : %d",_currentIndex) ;
}

- (void)resetOffsetYOfEveryTable
{
    // reset tableview offset Y.
    [((XTTableViewRootHandler *)_list_handlers[_currentIndex]) refreshOffsetYWithTable:_centerTable] ;
    int leftIndex   = (_currentIndex + self.allCount - 1) % self.allCount ;
    int rightIndex  = (_currentIndex + 1) % self.allCount ;
    [(XTTableViewRootHandler *)_list_handlers[leftIndex] refreshOffsetYWithTable:_leftTable] ;
    [(XTTableViewRootHandler *)_list_handlers[rightIndex] refreshOffsetYWithTable:_rightTable] ;
}


@end
