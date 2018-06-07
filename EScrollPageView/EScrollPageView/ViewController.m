//
//  ViewController.m
//  EScrollPageView
//
//  Created by Easy on 2018/6/7.
//  Copyright © 2018年 Easy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    bt.backgroundColor = [UIColor redColor];
    [self.view addSubview:bt];
    [bt addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)buttonClick{
    [self.navigationController pushViewController:[[NSClassFromString(@"EScrollPageViewController") alloc] init] animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
