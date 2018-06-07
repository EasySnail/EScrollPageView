//
//  ViewController.m
//  EScrollPageView
//
//  Created by Easy on 2018/6/7.
//  Copyright © 2018年 Easy. All rights reserved.
//

#import "ViewController.h"
#import "Test1VC.h"
#import "Test2VC.h"
#import "Test3VC.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];
    self.title = @"主页";
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 2:{
            Test1VC *vc = [[Test1VC alloc] init];
            vc.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
            [self.navigationController pushViewController:vc animated:true];
        }break;
        case 3:{
            Test3VC *vc = [[Test3VC alloc] init];
            [self.navigationController pushViewController:vc animated:true];
        }break;
        case 0:
        case 1:{
            Test2VC *vc = [[Test2VC alloc] init];
            vc.type = (int)indexPath.row;
            vc.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
            [self.navigationController pushViewController:vc animated:true];
        }break;
            
        default:
            break;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row) {
        case 3:
            cell.textLabel.text = @"嵌套滚动2";
            break;
        case 2:
            cell.textLabel.text = @"嵌套滚动1";
            break;
        case 0:
            cell.textLabel.text = @"分页1";
            break;
        case 1:
            cell.textLabel.text = @"分页2";
            break;
        default:
            cell.textLabel.text = nil;
            break;
    }
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
