//
//  EScrollPageView.h
//  滚动嵌套
//
//  Created by Easy on 2018/6/1.
//  Copyright © 2018年 Easy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPageSegmentCT.h"

@class EScrollPageItemBaseView;
@class EScrollPageParam;
@class EPageSegmentParam;


@interface EScrollPageView : UIView

@property(nonatomic,assign)NSInteger currenIndex;

- (instancetype)initWithFrame:(CGRect)frame dataViews:(NSArray<EScrollPageItemBaseView *> *)dataViews;
- (instancetype)initWithFrame:(CGRect)frame dataViews:(NSArray<EScrollPageItemBaseView *> *)dataViews setParam:(EScrollPageParam *)param;

@end






/******************************每一项(子类继承)**************************/

@interface EScrollPageItemBaseView : UIView

- (instancetype)initWithPageTitle:(NSString *)title;
- (void)didAppeared;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,copy)void(^didAddScrollViewBlock)(UIScrollView *scrollView ,NSInteger index);
@end


/********************************* 设置参数 ****************************/

@interface EScrollPageParam : NSObject

+ (EScrollPageParam *)defaultParam;
@property(nonatomic,assign)CGFloat headerHeight;              //头部分栏高度
@property(nonatomic,retain)EPageSegmentParam *segmentParam;   //头部设置参数

@end


