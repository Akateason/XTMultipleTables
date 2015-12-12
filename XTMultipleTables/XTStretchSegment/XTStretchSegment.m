//
//  XTStretchSegment.m
//  XTMultipleTables
//
//  Created by TuTu on 15/12/11.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "XTStretchSegment.h"

static const float kWordsHeadNailFlexLength = 10.0f ;
static const int   kTopButtonTagBasic = 5438 ;
static const float kTopButtonFontSize = 17.0 ;
static const float kOverlayAnimationDuration = 0.25f ;

@interface XTStretchSegment ()
{
    CGRect m_overlayFrame ;
}
@property (nonatomic,readonly) BOOL hasBaseline ;
@property (nonatomic,strong) UIImageView *overlayView ;
@end

@implementation XTStretchSegment

#pragma mark - Initial
- (instancetype)initWithFrame:(CGRect)frame
                     dataList:(NSArray *)dataList
{
    return [self initWithFrame:frame
                      dataList:dataList
                      baseLine:NO
                  overlayImage:[UIImage imageNamed:@"btBase"]] ;
}

- (instancetype)initWithFrame:(CGRect)frame
                     dataList:(NSArray *)dataList
                     baseLine:(BOOL)hasBaseline
                 overlayImage:(UIImage *)imgOverlay
{
    self = [super initWithFrame:frame];
    if (self) {
        _hasBaseline = hasBaseline ;
        self.dataList = dataList ;
        self.overlayView.image = imgOverlay ;
        [self setup] ;
    }
    return self;
}

- (CGSize)topButtonMaxSize { return CGSizeMake(1000, self.frame.size.height) ; }

- (CGFloat)getButtonWidth:(NSString *)nameBt
{
    CGFloat wid = [nameBt boundingRectWithSize:[self topButtonMaxSize]
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kTopButtonFontSize]}
                                       context:nil].size.width ;
    wid += (kWordsHeadNailFlexLength * 2) ;
    return wid ;
}

- (CGRect)getRectFromWhichButton:(int)index
{
    __block float sumOfPreLength = 0.0 ;
    [self.dataNameList enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL * _Nonnull stop) {
        
        sumOfPreLength += [self getButtonWidth:name] ;
        
        if (idx == index - 1) {
            *stop = YES ;
        }
    }] ;
    
    sumOfPreLength = (!index) ? 0 : sumOfPreLength ;
    
    return CGRectMake(sumOfPreLength ,
                      0,
                      [self getButtonWidth:self.dataNameList[index]],
                      self.frame.size.height) ;
}

- (void)drawBaseLine:(float)length
{
    UIView *baseline = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                self.frame.size.height - 1,
                                                                length,
                                                                1)] ;
    baseline.backgroundColor = [UIColor blackColor] ;
    [self addSubview:baseline] ;
}

#pragma mark - Property
- (void)setDataList:(NSArray *)dataList
{
    _dataList = dataList ;
    
    NSMutableArray *templist = [[NSMutableArray alloc] init] ;
    [dataList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *name = [[obj allKeys] firstObject] ;
        [templist addObject:name] ;
        if (idx == dataList.count - 1) {
            self.dataNameList = templist ;
            *stop = YES ;
        }
    }] ;
}

- (void)setDataNameList:(NSArray *)dataNameList
{
    _dataNameList = dataNameList ;
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex ;
    
    [self movingOverlay] ;
}

- (UIImageView *)overlayView
{
    if (!_overlayView) {
        _overlayView = [[UIImageView alloc] init] ;
        if (![_overlayView superview]) {
            [self addSubview:_overlayView] ;
        }
    }
    
    return _overlayView ;
}

#pragma mark - Setup
- (void)setup
{
    [self setupButtonsAndBaseline] ;
    [self setupDefaultOverlay] ;
    self.currentIndex = 0 ;
    self.showsHorizontalScrollIndicator = NO ;
}

- (void)setupButtonsAndBaseline
{
    __block CGFloat sumOflatestButtonsWidth = 0.0 ;
    
    [_dataNameList enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *bt = [[UIButton alloc] init] ;
        [bt setTitle:name forState:0] ;
        [bt setTitleColor:[UIColor redColor] forState:0] ;
        bt.titleLabel.font = [UIFont systemFontOfSize:kTopButtonFontSize] ;
        bt.tag = kTopButtonTagBasic + idx ;
        [bt addTarget:self action:@selector(clickOnWhichButton:) forControlEvents:UIControlEventTouchUpInside] ;
        CGRect btFrame = CGRectZero ;
        btFrame.origin.x = sumOflatestButtonsWidth ;
        btFrame.size.width = [self getButtonWidth:name] ;
        btFrame.size.height = self.frame.size.height ;
        bt.frame = btFrame ;
        [self addSubview:bt] ;
        sumOflatestButtonsWidth += btFrame.size.width ;
        if (_dataNameList.count - 1 == idx) {
            self.contentSize = CGSizeMake(sumOflatestButtonsWidth, self.frame.size.height) ;
            if (_hasBaseline) {
                [self drawBaseLine:sumOflatestButtonsWidth] ;
            }
            *stop = YES ;
        }
    }] ;
}

- (void)setupDefaultOverlay
{
    m_overlayFrame = [self getRectFromWhichButton:0] ;
}

- (void)clickOnWhichButton:(UIButton *)button
{
//    NSLog(@"tag : %ld is selected",(long)button.tag) ;
    int selectedIndex = (int)button.tag - kTopButtonTagBasic ;
    NSLog(@"selectedIndex : %d",selectedIndex) ;
    if (_currentIndex == selectedIndex) return ;
    
    self.currentIndex = selectedIndex ;
    [self.xtDelegate xtStretchSegmentMoveToTheIndex:selectedIndex
                                           dataItem:_dataList[selectedIndex]] ;
}

- (void)movingOverlay
{
    CGRect rectShouldMove = [self getRectFromWhichButton:(int)_currentIndex] ;
    if (CGRectEqualToRect(rectShouldMove, self.overlayView.frame)) return ;
    

    [UIView animateWithDuration:kOverlayAnimationDuration
                     animations:^{
                         self.overlayView.frame = rectShouldMove ;
                         [self scrollRectToVisible:self.overlayView.frame animated:YES] ;
                     }
                     completion:nil] ;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
