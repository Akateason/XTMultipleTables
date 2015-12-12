//
//  ViewController.m
//  XTMultipleTables
//
//  Created by TuTu on 15/12/4.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "ViewController.h"
#import "XTMultipleTables.h"
#import "TableHandler_homePage.h"
#import "TableHander_ entertainment.h"
#import "TableHandler_hot.h"
#import "XTStretchSegment.h"

@interface ViewController () <XTStretchSegmentDelegate, XTMultipleTablesDelegate>
@property (nonatomic,strong) NSArray *list_homePage ;
@property (nonatomic,strong) NSArray *list_entertainment ;
@property (nonatomic,strong) NSArray *list_hot ;

@property (nonatomic,strong) XTStretchSegment *xtStretchSegment ;
@property (nonatomic,strong) XTMultipleTables *xtMultipleTables ;
@end

@implementation ViewController

+ (CGRect)getTopRect
{
    return CGRectMake(0, 20, APPFRAME.size.width, 40) ;
}

+ (CGRect)getMainRect
{
    return CGRectMake(0, 60, APPFRAME.size.width, APPFRAME.size.height  - 60) ;
}

- (NSArray *)list_homePage
{
    if (!_list_homePage) {
        NSMutableArray *tempList = [[NSMutableArray alloc] init] ;
        for (int i = 0; i < 25; i++) {
            [tempList addObject:[NSString stringWithFormat:@"首页,%d",i]] ;
        }
        _list_homePage = tempList ;
    }
    return _list_homePage ;
}

- (NSArray *)list_entertainment
{
    return @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10] ;
}

- (NSArray *)list_hot
{
    if (!_list_hot) {
        NSMutableArray *tempList = [[NSMutableArray alloc] init] ;
        for (int i = 0; i < 25; i++) {
            [tempList addObject:[NSString stringWithFormat:@"热点,%d",i]] ;
        }
        _list_hot = tempList ;
    }
    return _list_hot ;
}


- (void)viewDidLoad {
    [super viewDidLoad] ;
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController setNavigationBarHidden:YES] ;
    
// 1. XTStretchSegment
    NSMutableArray *tempDatalist = [[NSMutableArray alloc] init] ;
    NSArray *namelist = @[@"首页",@"娱乐",@"热点",@"新闻",@"动态",@"啊啊啊",@"沙发垫",@"32154",@"test",@"顿发生地方阿斯顿发评批评",@"好的",@"很好",@"发达",@"阿斯顿"] ;
    for (int i = 0; i < namelist.count; i++) {
        NSDictionary *dic = @{namelist[i] : @(i)} ;
        [tempDatalist addObject:dic] ;
    }
    self.xtStretchSegment = [[XTStretchSegment alloc] initWithFrame:[[self class] getTopRect]
                                                           dataList:tempDatalist] ;
    self.xtStretchSegment.xtDelegate = self ;
    [self.view addSubview:self.xtStretchSegment] ;
    
    
// 2. XTMultipleTables
    TableHandler_homePage *handler_home = [[TableHandler_homePage alloc] initWithDataList:self.list_homePage] ;
    TableHander__entertainment *handler_entertainment = [[TableHander__entertainment alloc] initWithDataList:self.list_entertainment] ;
    TableHandler_hot *handler_hot = [[TableHandler_hot alloc] initWithDataList:self.list_hot] ;
    XTTableViewRootHandler *handler_Temp = [[XTTableViewRootHandler alloc] initWithDataList:self.list_hot] ;
    
    NSMutableArray *tableHandlersList = [@[handler_home,handler_entertainment,handler_hot] mutableCopy] ;
    for (int i = 3; i < namelist.count; i++) {
        [tableHandlersList addObject:handler_Temp] ;
    }
    
    self.xtMultipleTables = [[XTMultipleTables alloc] initWithFrame:[[self class] getMainRect]
                                                           handlers:tableHandlersList] ;
    self.xtMultipleTables.xtDelegate = self ;
    [self.view addSubview:self.xtMultipleTables] ;
}

#pragma mark - XTStretchSegmentDelegate
- (void)xtStretchSegmentMoveToTheIndex:(NSInteger)index
                              dataItem:(id)item
{
    [self.xtMultipleTables xtMultipleTableMoveToTheIndex:(int)index] ;
}

#pragma mark - XTMultipleTablesDelegate
- (void)moveToIndexCallBack:(int)index
{
    self.xtStretchSegment.currentIndex = index ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
