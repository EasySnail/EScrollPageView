//
//  EScrollPageViewController.m
//  滚动嵌套
//
//  Created by Easy on 2018/6/1.
//  Copyright © 2018年 Easy. All rights reserved.
//

#import "EScrollPageViewController.h"
#import "ENestScrollPageView.h"
#import "PageItemTestView.h"
@interface EScrollPageViewController ()

@property(nonatomic,retain)ENestScrollPageView *pageView;


@end

@implementation EScrollPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self pageView];
    // Do any additional setup after loading the view.
}
- (ENestScrollPageView *)pageView{
    if (_pageView == nil) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
        headView.backgroundColor = [UIColor purpleColor];
        
        EScrollPageItemBaseView *v1 = [[PageItemTestView alloc] initWithPageTitle:@"个人"];
        EScrollPageItemBaseView *v2 = [[PageItemTestView alloc] initWithPageTitle:@"国家"];
        EScrollPageItemBaseView *v3 = [[PageItemTestView alloc] initWithPageTitle:@"地球"];
        EScrollPageItemBaseView *v4 = [[PageItemTestView alloc] initWithPageTitle:@"宇宙"];
        EScrollPageItemBaseView *v5 = [[PageItemTestView alloc] initWithPageTitle:@"mine"];
        NSArray *vs = @[v1,v2,v3,v4,v5];
        
        _pageView = [[ENestScrollPageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) headView:headView subDataViews:vs setParam:nil];
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
