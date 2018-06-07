//
//  Test1VC.m
//  EScrollPageView
//
//  Created by Easy on 2018/6/7.
//  Copyright © 2018年 Easy. All rights reserved.
//

#import "Test1VC.h"
#import "ENestScrollPageView.h"

@interface Test1VC ()
@property(nonatomic,retain)ENestScrollPageView *pageView;
@end

@implementation Test1VC

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
        EScrollPageItemBaseView *v1 = [[Test1ItemView alloc] initWithPageTitle:@"个人"];
        EScrollPageItemBaseView *v2 = [[Test1ItemView alloc] initWithPageTitle:@"国家"];
        EScrollPageItemBaseView *v3 = [[Test1ItemView alloc] initWithPageTitle:@"地球"];
        EScrollPageItemBaseView *v4 = [[Test1ItemView alloc] initWithPageTitle:@"宇宙"];
        EScrollPageItemBaseView *v5 = [[Test1ItemView alloc] initWithPageTitle:@"mine"];
        
        
        NSArray *vs = @[v1,v2,v3,v4,v5];
        //设置一些参数等等。。。
        ENestParam *param = [[ENestParam alloc] init];
        //从0开始
        param.scrollParam.segmentParam.startIndex = 0;
        //字体颜色等
        param.scrollParam.segmentParam.textColor = 0x000000;
        //分栏高度
        param.scrollParam.headerHeight = 40;
        
        
        CGFloat nvBarH = ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0);
        _pageView = [[ENestScrollPageView alloc] initWithFrame:CGRectMake(0, nvBarH, self.view.frame.size.width, self.view.frame.size.height-nvBarH) headView:headView subDataViews:vs setParam:param];
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





/********************************************************/
@implementation Test1ItemView

- (void)didAppeared{
    [self tableView];
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        
        
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        //        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
        //        _tableView.tableHeaderView = view;
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ -->%ld",self.title,indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}




@end
