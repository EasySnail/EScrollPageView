//
//  Test1VC.h
//  EScrollPageView
//
//  Created by Easy on 2018/6/7.
//  Copyright © 2018年 Easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ENestScrollPageView.h"

@class EScrollPageItemBaseView;

@interface Test1VC : UIViewController

@end





/***************子类继承***********************/

@interface Test1ItemView:EScrollPageItemBaseView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)UITableView *tableView;
@end


