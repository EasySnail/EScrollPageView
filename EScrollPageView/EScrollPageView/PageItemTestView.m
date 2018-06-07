//
//  PageItemTestView.m
//  滚动嵌套
//
//  Created by Easy on 2018/6/4.
//  Copyright © 2018年 Easy. All rights reserved.
//

#import "PageItemTestView.h"
@interface PageItemTestView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView *tableView;
@end

@implementation PageItemTestView


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
    return 40;
}

@end
