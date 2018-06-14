//
//  EWaterFallView.h
//  EWaterFallView
//
//  Created by Easy on 2018/6/11.
//  Copyright © 2018年 Easy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EWaterFallLayout;

@interface EWaterFallView : UIView

//注册复用cell,给定类名二选一
@property(nonatomic,copy)NSString *registerClassCell;
@property(nonatomic,copy)NSString *registerNibCell;

//可以设置如mj的刷新加载等
@property(nonatomic,readonly,strong)UICollectionView *collectionView;

//初始化一些设置
@property(nonatomic, copy)void(^setParamBlock)(EWaterFallLayout *layout);

//返回总数
@property(nonatomic, copy)NSInteger(^numberOfRowsBlock)(void);

//返回每个item的高度
@property(nonatomic, copy)CGFloat(^itemHeightBlock)(CGFloat itemWidth,NSIndexPath *indexPath);

//cell设置
@property(nonatomic,copy)id(^cellDataBlock)(UICollectionViewCell *cell, NSIndexPath *indexPath);

//点击cell
@property(nonatomic,copy)void(^didSelectAtIndexPathBlock)(NSIndexPath *indexPath);

//刷新数据
- (void)reloadData;
@end







/************************ layout ***************************/

@interface EWaterFallLayout : UICollectionViewLayout
@property (nonatomic, assign) NSInteger columnCount;                //总列数
@property (nonatomic, assign) NSInteger columnSpacing;              //列间距
@property (nonatomic, assign) NSInteger rowSpacing;                 //行间距
@property (nonatomic, assign) UIEdgeInsets sectionInset;            //section到collectionView的边距

@property (nonatomic, strong) NSMutableDictionary *maxYDic;         //保存每一列最大y值的数组
@property (nonatomic, strong) NSMutableArray *attributesArray;      //保存每一个item的attributes的数组
@property (nonatomic, strong) CGFloat(^itemHeightBlock)(CGFloat itemWidth,NSIndexPath *indexPath);
@end





/************************ 协议 ***************************/
@protocol EWaterFallCellProtocol <NSObject>
@optional
- (void)updateData:(id)data indexPath:(NSIndexPath *)indexPath;
@end
