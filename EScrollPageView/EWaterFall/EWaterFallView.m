//
//  EWaterFallView.m
//  EWaterFallView
//
//  Created by Easy on 2018/6/11.
//  Copyright © 2018年 Easy. All rights reserved.
//

#import "EWaterFallView.h"

@interface EWaterFallView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,readwrite,strong) UICollectionView *collectionView;
@property(nonatomic,strong)EWaterFallLayout *layout;
@end

@implementation EWaterFallView

- (instancetype)init{
    CGSize size = [UIScreen mainScreen].bounds.size;
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (self) {
        
    }
    return self;
}

- (void)reloadData{
    [self.collectionView reloadData];
}

- (void)setItemHeightBlock:(CGFloat (^)(CGFloat, NSIndexPath *))itemHeightBlock{
    self.layout.itemHeightBlock = itemHeightBlock;
}
- (EWaterFallLayout *)layout{
    if (_layout == nil) {
        _layout = [[EWaterFallLayout alloc] init];
        _layout.columnCount = 2;
        _layout.columnSpacing = 5;
        _layout.rowSpacing = 5;
        _layout.sectionInset = UIEdgeInsetsZero;
    }
    return _layout;
}
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        if (self.setParamBlock) {self.setParamBlock(self.layout);}
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        if (self.registerClassCell) {
            [_collectionView registerClass:NSClassFromString(_registerClassCell) forCellWithReuseIdentifier:@"cell"];
        }else if (self.registerNibCell){
            [_collectionView registerNib:[UINib nibWithNibName:_registerNibCell bundle:nil] forCellWithReuseIdentifier:@"cell"];
        }else{
            [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        }
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didSelectAtIndexPathBlock) {
        self.didSelectAtIndexPathBlock(indexPath);
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.numberOfRowsBlock) {return self.numberOfRowsBlock();}
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell<EWaterFallCellProtocol> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    id data = nil;
    if (self.cellDataBlock) {data = self.cellDataBlock(cell,indexPath);}
    if ([cell respondsToSelector:@selector(updateData:indexPath:)]) {
        [cell updateData:data indexPath:indexPath];
    }
    return cell;
}

@end


/************************ layout ***************************/

@implementation EWaterFallLayout

#pragma mark- 懒加载
- (NSMutableDictionary *)maxYDic {
    if (!_maxYDic) {_maxYDic = [[NSMutableDictionary alloc] init];}
    return _maxYDic;
}
- (NSMutableArray *)attributesArray {
    if (!_attributesArray) {_attributesArray = [NSMutableArray array];}
    return _attributesArray;
}
#pragma mark- 构造方法
- (instancetype)init{
    if (self = [super init]) {
        self.columnCount = 2;
    }
    return self;
}
- (instancetype)initWithColumnCount:(NSInteger)columnCount {
    if (self = [super init]) {
        self.columnCount = columnCount;
    }
    return self;
}
#pragma mark- 布局相关方法
//布局前的准备工作
- (void)prepareLayout {
    [super prepareLayout];
    //初始化字典，有几列就有几个键值对，key为列，value为列的最大y值，初始值为上内边距
    for (int i = 0; i < self.columnCount; i++) {
        self.maxYDic[@(i)] = @(self.sectionInset.top);
    }
    //根据collectionView获取总共有多少个item
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    [self.attributesArray removeAllObjects];
    //为每一个item创建一个attributes并存入数组
    for (int i = 0; i < itemCount; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attributesArray addObject:attributes];
    }
}

//计算collectionView的contentSize
- (CGSize)collectionViewContentSize {
    __block NSNumber *maxIndex = @0;
    //遍历字典，找出最长的那一列
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL *stop) {
        if ([self.maxYDic[maxIndex] floatValue] < obj.floatValue) {
            maxIndex = key;
        }
    }];
    //collectionView的contentSize.height就等于最长列的最大y值+下内边距
    return CGSizeMake(0, [self.maxYDic[maxIndex] floatValue] + self.sectionInset.bottom);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //根据indexPath获取item的attributes
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //获取collectionView的宽度
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    //item的宽度 = (collectionView的宽度 - 内边距与列间距) / 列数
    CGFloat itemWidth = (collectionViewWidth - self.sectionInset.left - self.sectionInset.right - (self.columnCount - 1) * self.columnSpacing) / self.columnCount;
    CGFloat itemHeight = 50;
    //获取item的高度，由外界计算得到
    if (self.itemHeightBlock) itemHeight = self.itemHeightBlock(itemWidth, indexPath);
    //找出最短的那一列
    __block NSNumber *minIndex = @0;
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL *stop) {
        if ([self.maxYDic[minIndex] floatValue] > obj.floatValue) {
            minIndex = key;
        }
    }];
    //根据最短列的列数计算item的x值
    CGFloat itemX = self.sectionInset.left + (self.columnSpacing + itemWidth) * minIndex.integerValue;
    //item的y值 = 最短列的最大y值 + 行间距
    CGFloat itemY = [self.maxYDic[minIndex] floatValue] + self.rowSpacing;
    //设置attributes的frame
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    //更新字典中的最大y值
    self.maxYDic[minIndex] = @(CGRectGetMaxY(attributes.frame));
    return attributes;
}
//返回rect范围内item的attributes
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}



@end
