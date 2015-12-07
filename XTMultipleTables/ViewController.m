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


@interface ViewController ()
@property (nonatomic,strong) NSArray *list_homePage ;
@property (nonatomic,strong) NSArray *list_entertainment ;
@property (nonatomic,strong) NSArray *list_hot ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad] ;
    // Do any additional setup after loading the view, typically from a nib.
    
    TableHandler_homePage *handler_home = [[TableHandler_homePage alloc] initWithDataList:self.list_homePage] ;
    TableHander__entertainment *handler_entertainment = [[TableHander__entertainment alloc] initWithDataList:self.list_entertainment] ;
    TableHandler_hot *handler_hot = [[TableHandler_hot alloc] initWithDataList:self.list_hot] ;
    
    
    NSArray *tableHandlersList = @[handler_home,handler_entertainment,handler_hot] ;
    XTMultipleTables *multipleTable = [[XTMultipleTables alloc] initWithFrame:self.view.bounds
                                                                     handlers:tableHandlersList] ;
    [self.view addSubview:multipleTable] ;
    
}

- (NSArray *)list_homePage
{
    if (!_list_homePage) {
        NSMutableArray *tempList = [[NSMutableArray alloc] init] ;
        for (int i = 0; i < 15; i++) {
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
        for (int i = 0; i < 15; i++) {
            [tempList addObject:[NSString stringWithFormat:@"热点,%d",i]] ;
        }
        _list_hot = tempList ;
    }
    return _list_hot ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
