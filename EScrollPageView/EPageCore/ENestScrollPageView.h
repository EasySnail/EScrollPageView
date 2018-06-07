//
//  ENestScrollPageView.h
//  滚动嵌套
//
//  Created by Easy on 2018/6/5.
//  Copyright © 2018年 Easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EScrollPageView.h"

@class ENestParam;
@class EScrollPageItemBaseView;
@class EScrollPageParam;

@interface ENestScrollPageView : UIView
- (instancetype)initWithFrame:(CGRect)frame headView:(UIView *)headView subDataViews:(NSArray<EScrollPageItemBaseView *> *)dataViews;
- (instancetype)initWithFrame:(CGRect)frame headView:(UIView *)headView subDataViews:(NSArray<EScrollPageItemBaseView *> *)dataViews setParam:(ENestParam *)param;

- (UIScrollView *)eScrollView;                                //返回scrollview
@property(nonatomic,copy)void(^didScrollBlock)(CGFloat dy);   //滚动回调

@end




/**************************  参数  *****************************/
@interface ENestParam:NSObject
@property(nonatomic,retain)EScrollPageParam *scrollParam;     //分页设置的参数
@property(nonatomic,assign)CGFloat yOffset;                   //停留位置


+ (ENestParam *)defaultParam;
@end


/********************** 多手势同时识别 ***************************/
@interface ESMGRScrollView : UIScrollView
@property(nonatomic,weak)NSArray *viewArray;     //自己和viewArray上的首饰
@end


