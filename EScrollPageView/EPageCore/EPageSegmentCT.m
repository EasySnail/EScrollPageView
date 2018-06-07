//
//  EPageSegmentCT.m
//  滚动嵌套
//
//  Created by Easy on 2018/6/1.
//  Copyright © 2018年 Easy. All rights reserved.
//

#import "EPageSegmentCT.h"

#define ERGBColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define EFont(fontValue) [UIFont systemFontOfSize:fontValue]
@interface EPageSegmentCT()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,retain)UICollectionView *collectionView;
@property(nonatomic,retain)NSArray *dataArray;
@property(nonatomic,retain)EPageSegmentParam *param;                                        //设置参数
@property(nonatomic,assign)CGFloat itemWidth;                                               //平均宽度
@property(nonatomic,assign)NSInteger selectedIndex;                                         //当前选择
@property(nonatomic,retain)UIView *lineView;
@property(nonatomic,retain)NSMutableArray *cellArray;


@end

@implementation EPageSegmentCT

- (instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame setParam:nil data:nil];
}
- (instancetype)initWithFrame:(CGRect)frame setParam:(EPageSegmentParam *)param{
    return [self initWithFrame:frame setParam:param data:nil];
}
- (instancetype)initWithFrame:(CGRect)frame setParam:(EPageSegmentParam *)param data:(NSArray<NSString *> *)data
{
    self = [super initWithFrame:frame];
    if (self) {
        if (param == nil) {param = [EPageSegmentParam defaultParam];}
        self.selectedIndex = param.startIndex;
        self.param = param;
        self.dataArray = data;
        if (_dataArray) {[self collectionView];}
        self.backgroundColor = ERGBColor(param.bgColor);
    }
    return self;
}

- (void)updataDataArray:(NSArray<NSString *> *)data{
    self.dataArray = data;
    [[self collectionView] reloadData];
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        CGFloat dh = self.frame.size.height;
        UICollectionViewFlowLayout *laout = [[UICollectionViewFlowLayout alloc] init];
        laout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        laout.sectionInset = UIEdgeInsetsMake(0, _param.margin_spacing, 0, _param.margin_spacing);
        laout.minimumLineSpacing = _param.spacing;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, dh) collectionViewLayout:laout];
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[EPageSegmentCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [self addSubview:_collectionView];
        [self lineView];
        
        UIView *bline = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
        bline.backgroundColor = ERGBColor(_param.botLineColor);
        UIView *tline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
        tline.backgroundColor = ERGBColor(_param.topLineColor);
        [self addSubview:bline];
        [self addSubview:tline];
    }
    return _collectionView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat dh = self.frame.size.height;
    return CGSizeMake(self.itemWidth, dh);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.associatedSscrollBlock == nil) {
        self.selectedIndex = indexPath.row;
        [collectionView reloadData];
    }
    if (self.didSelectedIndexBlock) {
        self.didSelectedIndexBlock(indexPath.row);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EPageSegmentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell updateText:_dataArray[indexPath.row] param:self.param];
    [cell didSelected:(indexPath.row == self.selectedIndex)];
    if (self.cellArray == nil) {self.cellArray = [NSMutableArray array];}
    if (![self.cellArray containsObject:cell]) {[self.cellArray addObject:cell];}
    return cell;
}
- (void)selectIndex:(NSInteger)index animated:(BOOL)animated{
    self.selectedIndex = index;
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:true scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}
- (void)setAssociatedScroll{
    __weak EPageSegmentCT *weakSelf = self;
    self.associatedSscrollBlock = ^(UIScrollView *scrollView) {
        if (weakSelf.collectionView.contentSize.width <= 0) {return;}
        int page = scrollView.contentOffset.x / scrollView.frame.size.width;
        CGFloat dx = scrollView.contentOffset.x;
        if (dx < 0.0) {dx = 0;page = -1;}
        if (dx > scrollView.contentSize.width-scrollView.frame.size.width) {
            dx = scrollView.contentSize.width-scrollView.frame.size.width;
            page = -1;
        }
        CGFloat dw = weakSelf.collectionView.contentSize.width - weakSelf.param.margin_spacing;
        CGFloat lx = dx * dw / scrollView.contentSize.width;
        
        weakSelf.lineView.frame = CGRectMake(weakSelf.param.margin_spacing+lx, weakSelf.lineView.frame.origin.y, weakSelf.lineView.frame.size.width, weakSelf.lineView.frame.size.height);
        if (page >= 0) {
            CGFloat dspace = weakSelf.itemWidth + weakSelf.param.spacing;
            
            for (EPageSegmentCell *cell in [weakSelf cellArray]) {
                CGFloat scale = fabs(cell.center.x-weakSelf.lineView.center.x)/dspace;
                if (scale <= 1.0) {
                    CGFloat fontSize = weakSelf.param.selectedfontSize + (weakSelf.param.fontSize - weakSelf.param.selectedfontSize)*scale;
                    cell.textLabel.font = EFont(fontSize);
                    float sr = (float)((weakSelf.param.textSelectedColor & 0xFF0000) >> 16);
                    float sg = (float)((weakSelf.param.textSelectedColor & 0xFF00) >> 8);
                    float sb = (float)(weakSelf.param.textSelectedColor & 0xFF);
                    float r = (float)((weakSelf.param.textColor & 0xFF0000) >> 16);
                    float g = (float)((weakSelf.param.textColor & 0xFF00) >> 8);
                    float b = (float)(weakSelf.param.textColor & 0xFF);
                    cell.textLabel.textColor = [UIColor colorWithRed: (sr+(r-sr)*scale)/255.0 green:(sg+(g-sg)*scale)/255.0 blue:(sb+(b-sb)*scale)/255.0 alpha:1];
                }else{
                    cell.textLabel.textColor = ERGBColor(weakSelf.param.textColor);
                    cell.textLabel.font = EFont(weakSelf.param.fontSize);
                }
            }
        }
    };
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(_param.margin_spacing+(self.itemWidth+_param.spacing)*_param.startIndex, self.collectionView.frame.size.height-2, self.itemWidth, 2)];
        _lineView.hidden = !_param.showLine;
        CGFloat lineW = self.param.lineWidth < 0 ? self.itemWidth*0.6 : self.param.lineWidth;
        UIView *sline = [[UIView alloc] initWithFrame:CGRectMake((_lineView.frame.size.width-lineW)*0.5, 0, lineW, _lineView.frame.size.height)];
        [_lineView addSubview:sline];
        sline.backgroundColor = self.param.lineColor;
        [self.collectionView addSubview:_lineView];
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.param.startIndex inSection:0] animated:true scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
    return _lineView;
}
- (CGFloat)itemWidth{
    if (_itemWidth <= 0) {
        switch (self.param.type) {
            case EPageContentLeft:
                _itemWidth = self.param.itemWidth;
                break;
            case EPageContentBetween:
                _itemWidth = (_collectionView.frame.size.width - 2*_param.margin_spacing - (_dataArray.count-1)*_param.spacing)/_dataArray.count;
                break;
            default:
                break;
        }
    }
    return _itemWidth;
}
@end

/******************************* Param ********************************/
@implementation EPageSegmentParam

+ (EPageSegmentParam *)defaultParam{
    return [[EPageSegmentParam alloc] init];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = EPageContentBetween;
        self.spacing = 5;
        self.margin_spacing = 5;
        self.textSelectedColor = 0xFF0000;
        self.textColor = 0x000000;
        self.showLine = true;
        self.lineWidth = -1;
        self.lineColor = [UIColor redColor];
        self.fontSize = 15;
        self.selectedfontSize = 15;
        self.startIndex = 0;
        self.bgColor = 0xfcfcfc;
        self.topLineColor = 0xcdcdcd;
        self.botLineColor = 0xcdcdcd;
        self.itemWidth = 80;
    }
    return self;
}

@end

/******************************* Cell *********************************/
@implementation EPageSegmentCell

- (void)updateText:(NSString *)text param:(EPageSegmentParam *)param{
    self.param = param;
    self.textLabel.frame = self.contentView.bounds;
    self.textLabel.text = text;
}

- (void)didSelected:(BOOL)selected{
    self.textLabel.textColor = selected ? ERGBColor(_param.textSelectedColor) : ERGBColor(_param.textColor);
    self.textLabel.font = selected ? EFont(_param.selectedfontSize) : EFont(_param.fontSize);
}

- (UILabel *)textLabel{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:self.param.fontSize];
        _textLabel.textColor = ERGBColor(self.param.textColor);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_textLabel];
    }
    return _textLabel;
}

@end
