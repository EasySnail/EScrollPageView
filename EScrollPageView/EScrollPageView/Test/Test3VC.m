//
//  Test3VC.m
//  EScrollPageView
//
//  Created by Easy on 2018/6/7.
//  Copyright © 2018年 Easy. All rights reserved.
//

#import "Test3VC.h"
#import "ENestScrollPageView.h"
#import "Test1VC.h"
#import "Test4ItemView.h"

#define nvHeight  ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0)


@interface Test3VC ()
@property(nonatomic,retain)ENestScrollPageView *pageView;
@property(nonatomic,retain)UIView *navigationView;
@property(nonatomic,retain)Test3HeadView *headView;
@end

@implementation Test3VC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self pageView];
    [self navigationView];
    
    //没导航scrollView不能顶头,适配
    if (@available(iOS 11.0, *)) {
        [self.pageView eScrollView].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
//滚动
- (void)didScroll:(CGFloat)dy{
    
    //需要横向拉伸可直接设置imageView.contentMode = UIViewContentModeScaleAspectFill;
    CGRect rect = self.headView.bounds;
    if (dy < 0) {rect.size.height -= dy;}
    self.headView.bgImageView.bounds = rect;
    

    //更改导航，渐变根据距离计算
    BOOL show = ( dy >= self.headView.bounds.size.height - nvHeight);
    self.navigationView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:show ? 0.3 : 0];
    
    
}
- (ENestScrollPageView *)pageView{
    if (_pageView == nil) {
        //每一项的view子类需要继承EScrollPageItemBaseView实现相关界面
        EScrollPageItemBaseView *v1 = [[Test3ItemView alloc] initWithPageTitle:@"个人"];
        EScrollPageItemBaseView *v2 = [[Test1ItemView alloc] initWithPageTitle:@"国家"];
        EScrollPageItemBaseView *v3 = [[Test1ItemView alloc] initWithPageTitle:@"地球"];
        EScrollPageItemBaseView *v4 = [[Test4ItemView alloc] initWithPageTitle:@"宇宙"];
        EScrollPageItemBaseView *v5 = [[Test1ItemView alloc] initWithPageTitle:@"mine"];
        
        NSArray *vs = @[v1,v2,v3,v4,v5];
        //设置一些参数等等。。。
        ENestParam *param = [[ENestParam alloc] init];
        //从1开始
        param.scrollParam.segmentParam.startIndex = 1;
        //字体颜色等
        param.scrollParam.segmentParam.textColor = 0x000000;
        //分栏高度
        param.scrollParam.headerHeight = 40;
        //停留位置偏移
        param.yOffset = nvHeight;
        _pageView = [[ENestScrollPageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) headView:self.headView subDataViews:vs setParam:param];
        __weak Test3VC *weakSelf = self;
        //头部滚动
        _pageView.didScrollBlock = ^(CGFloat dy) {
            [weakSelf didScroll:dy];
        };
        [self.view addSubview:_pageView];
    }
    return _pageView;
}

- (Test3HeadView *)headView{
    if (_headView == nil) {
        _headView = [[Test3HeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 375.0*self.view.frame.size.width/600.0)];
    }
    return _headView;
}

- (UIView *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, nvHeight)];
        UIButton *back = [UIButton buttonWithType:UIButtonTypeSystem];
        back.frame = CGRectMake(0, nvHeight-44, 50, 44);
        [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        back.tintColor = [UIColor whiteColor];
        [_navigationView addSubview:back];
        [back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_navigationView];
    }
    return _navigationView;
}
//返回
- (void)backClick{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:false animated:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end




/******************** headview ************************/

@implementation Test3HeadView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self bgImageView];
    }
    return self;
}

- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height*0.5, self.frame.size.width, self.frame.size.height)];
        _bgImageView.layer.anchorPoint = CGPointMake(0.5, 1);
        _bgImageView.image = [UIImage imageNamed:@"testBg"];
        
        
        //横向拉伸
//        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_bgImageView];
    }
    return _bgImageView;
}

@end





