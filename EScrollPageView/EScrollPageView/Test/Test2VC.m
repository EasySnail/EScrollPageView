//
//  Test2VC.m
//  EScrollPageView
//
//  Created by Easy on 2018/6/7.
//  Copyright © 2018年 Easy. All rights reserved.
//

#import "Test2VC.h"
#import "EScrollPageView.h"
#import "Test1VC.h"

@interface Test2VC ()
@property(nonatomic,retain)EScrollPageView *pageView;
@end

@implementation Test2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self pageView];
    // Do any additional setup after loading the view.
}


- (EScrollPageView *)pageView{
    if (_pageView == nil) {
        CGFloat statusBarH = ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0);
        //每一项的view子类需要继承EScrollPageItemBaseView实现相关界面
        EScrollPageItemBaseView *v1 = [[Test1ItemView alloc] initWithPageTitle:@"个人"];
        EScrollPageItemBaseView *v2 = [[Test1ItemView alloc] initWithPageTitle:@"国家"];
        EScrollPageItemBaseView *v3 = [[Test1ItemView alloc] initWithPageTitle:@"地球"];
        EScrollPageItemBaseView *v4 = [[Test1ItemView alloc] initWithPageTitle:@"宇宙"];
        EScrollPageItemBaseView *v5 = [[Test1ItemView alloc] initWithPageTitle:@"mine"];
        NSArray *vs = @[v1,v2,v3,v4,v5];
        EScrollPageParam *param = [[EScrollPageParam alloc] init];
        if (_type == 1) {
            EScrollPageItemBaseView *v6 = [[EScrollPageItemBaseView alloc] initWithPageTitle:@"小米"];
            v6.backgroundColor = [UIColor yellowColor];
            EScrollPageItemBaseView *v7 = [[EScrollPageItemBaseView alloc] initWithPageTitle:@"诺基亚"];
            v7.backgroundColor = [UIColor redColor];
            EScrollPageItemBaseView *v8 = [[Test1ItemView alloc] initWithPageTitle:@"iPhone"];
            vs = @[v1,v2,v3,v4,v5,v6,v7,v8];
            //头部高度
            param.headerHeight = 50;
            //默认第3个
            param.segmentParam.startIndex = 2;
            //排列类型
            param.segmentParam.type = EPageContentLeft;
            //每个宽度，在type == EPageContentLeft，生效
            param.segmentParam.itemWidth = 60;
            //底部线颜色
            param.segmentParam.lineColor = [UIColor purpleColor];
            //背景颜色
            param.segmentParam.bgColor = 0xeeeeee;
            //正常字体颜色
            param.segmentParam.textColor = 0x000000;
            //选中的颜色
            param.segmentParam.textSelectedColor = 0x0afbea;
        }
        _pageView = [[EScrollPageView alloc] initWithFrame:CGRectMake(0, statusBarH, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-statusBarH) dataViews:vs setParam:param];
        [self.view addSubview:_pageView];
    }
    return _pageView;
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
