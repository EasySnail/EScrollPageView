//
//  EScrollPageView.m
//  滚动嵌套
//
//  Created by Easy on 2018/6/1.
//  Copyright © 2018年 Easy. All rights reserved.
//

#import "EScrollPageView.h"
#import <WebKit/WebKit.h>


@interface EScrollPageView()<UIScrollViewDelegate>
@property(nonatomic,retain)EPageSegmentCT *segmentCT;
@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)NSArray<EScrollPageItemBaseView *> *dataViews;

@property(nonatomic,retain)EScrollPageParam *param;
@end
@implementation EScrollPageView

- (instancetype)initWithFrame:(CGRect)frame dataViews:(NSArray<EScrollPageItemBaseView *> *)dataViews{
    return [self initWithFrame:frame dataViews:dataViews setParam:nil];
}

- (instancetype)initWithFrame:(CGRect)frame dataViews:(NSArray<EScrollPageItemBaseView *> *)dataViews setParam:(EScrollPageParam *)param
{
    self = [super initWithFrame:frame];
    if (self) {
        if (param == nil) {param = [EScrollPageParam defaultParam];}
        self.param = param;
        if (param.segmentParam.startIndex >= dataViews.count) {param.segmentParam.startIndex = 0;}
        self.currenIndex = param.segmentParam.startIndex;
        self.dataViews = dataViews;
        NSMutableArray *titles = [NSMutableArray array];
        for (int i = 0; i < _dataViews.count; ++i) {
            _dataViews[i].index = i;
            NSString *title = _dataViews[i].title;
            [titles addObject:(title == nil ? [NSString stringWithFormat:@"%d",i] : title)];
            _dataViews[i].frame = CGRectMake(i*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            [self.scrollView addSubview:_dataViews[i]];
            if (i == param.segmentParam.startIndex) {
                [_dataViews[i] didAppeared];
            }
        }
        self.scrollView.contentSize = CGSizeMake(_dataViews.count*self.scrollView.frame.size.width, 0);
        [self.segmentCT updataDataArray:titles];
        [self.segmentCT setAssociatedScroll];
        
        
        if (param.segmentParam.startIndex > 0) {
            [self.scrollView setContentOffset:CGPointMake(param.segmentParam.startIndex * self.scrollView.frame.size.width , 0) animated:false];
        }
    }
    return self;
}

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.param.headerHeight, self.frame.size.width, self.frame.size.height-self.param.headerHeight)];
        _scrollView.pagingEnabled = true;
        _scrollView.directionalLockEnabled = true;
        _scrollView.showsHorizontalScrollIndicator = false;
        
        [self addSubview:_scrollView];
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.segmentCT.associatedSscrollBlock) {
        self.segmentCT.associatedSscrollBlock(scrollView);
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self dealWithScroll];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self dealWithScroll];
}
- (void)dealWithScroll{
    int index = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    EScrollPageItemBaseView *view = [self.dataViews objectAtIndex:index];
    [view didAppeared];
    [self.segmentCT selectIndex:index animated:false];
    
    self.currenIndex = index;
}

- (EPageSegmentCT *)segmentCT{
    if (_segmentCT == nil) {
        _segmentCT = [[EPageSegmentCT alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.param.headerHeight) setParam:self.param.segmentParam];
        __weak EScrollPageView *weakSelf = self;
        _segmentCT.didSelectedIndexBlock = ^(NSInteger index) {
            [weakSelf.scrollView setContentOffset:CGPointMake(index * weakSelf.scrollView.frame.size.width , 0) animated:true];
        };
        [self addSubview:_segmentCT];
    }
    return _segmentCT;
}
@end




/*************************** 每一项 ******************************/
@implementation EScrollPageItemBaseView
- (instancetype)initWithPageTitle:(NSString *)title{
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}
- (void)didAddSubview:(UIView *)subview{
    [super didAddSubview:subview];
    if ([subview isKindOfClass:[UIScrollView class]]) {
        if (self.didAddScrollViewBlock) {
            self.didAddScrollViewBlock((UIScrollView *)subview,_index);
        }
    }else if ([subview isKindOfClass:[WKWebView class]]){
        if (self.didAddScrollViewBlock) {
            self.didAddScrollViewBlock(((WKWebView *)subview).scrollView,_index);
        }
    }else if ([subview isKindOfClass:[UIWebView class]]){
        if (self.didAddScrollViewBlock) {
            self.didAddScrollViewBlock(((UIWebView *)subview).scrollView,_index);
        }
    }else{
        for (UIView *sview in [subview subviews]) {
            if ([sview isKindOfClass:[UIScrollView class]]) {
                if (self.didAddScrollViewBlock) {
                    self.didAddScrollViewBlock((UIScrollView *)sview,_index);
                }
            }
        }
    }
}
- (void)didAppeared{}
@end

/*************************** 设置参数 ****************************/
@implementation EScrollPageParam
+ (EScrollPageParam *)defaultParam{
    return [[EScrollPageParam alloc] init];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerHeight = 40;
        self.segmentParam = [EPageSegmentParam defaultParam];
    }
    return self;
}
@end





